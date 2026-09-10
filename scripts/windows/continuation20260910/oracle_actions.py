"""Explicit, PID-bound native discovery mutations. Never used as setter repair.
Actions are limited to copied synthetic media and ITL4-named user playlists.
COM capability is checked against the installed type library before invocation.
Returned observations distinguish method completion from requested-value matching.
"""
import datetime
import pathlib
import re
import pythoncom
import pywintypes
import win32com.client
import native_oracle as n

TRACK_FIELDS = set('Name Artist Album AlbumArtist Composer Genre Comment Grouping Lyrics SortName SortArtist SortAlbum SortAlbumArtist SortComposer SortShow Rating AlbumRating PlayedCount PlayedDate SkippedCount SkippedDate TrackNumber TrackCount DiscNumber DiscCount Year BPM Compilation Enabled VolumeAdjustment Location EQ Start Finish RememberBookmark ExcludeFromShuffle Category Description LongDescription BookmarkTime VideoKind PartOfGaplessAlbum Show SeasonNumber EpisodeID EpisodeNumber Unplayed'.split())


def info(interface):
    lib = pythoncom.LoadTypeLib(str(n.EXE))
    for i in range(lib.GetTypeInfoCount()):
        if lib.GetDocumentation(i)[0] == interface:
            return lib.GetTypeInfo(i)
    raise ValueError('Installed interface not found: ' + interface)


def declared(interface, member, kind):
    ti = info(interface)
    matches = []
    for i in range(ti.GetTypeAttr().cFuncs):
        f = ti.GetFuncDesc(i)
        if f.invkind == kind and ti.GetNames(f.memid)[0].lower() == member.lower():
            matches.append(dict(member=ti.GetNames(f.memid)[0], memid=f.memid,
                                invkind=f.invkind, parameters=repr(f.args),
                                result=repr(f.rettype)))
    if len(matches) != 1:
        raise ValueError('Missing or ambiguous installed capability: ' + member)
    return matches[0]


def cast(obj, interface):
    iid = info(interface).GetTypeAttr().iid
    return win32com.client.dynamic.Dispatch(obj._oleobj_.QueryInterface(iid, pythoncom.IID_IDispatch))


def valid_pid(pid):
    if not isinstance(pid, str) or not re.fullmatch(r'[0-9A-F]{16}', pid) or int(pid, 16) == 0:
        raise ValueError('Expected a nonzero native persistent ID')
    return pid


def track(app, pid):
    valid_pid(pid)
    matches = [t for t in n.legacy.items(app.LibraryPlaylist.Tracks) if n.legacy.pid(app, t) == pid]
    if len(matches) != 1:
        raise ValueError('Track identity is not unique')
    obj = cast(matches[0], 'IITFileOrCDTrack')
    n.scoped(obj.Location, n.FIX)
    return obj


def playlist(app, pid, allowed):
    valid_pid(pid)
    if pid not in allowed:
        raise ValueError('Playlist PID not in the predeclared owned set')
    matches = [p for p in n.legacy.items(app.LibrarySource.Playlists) if n.legacy.pid(app, p) == pid]
    if len(matches) != 1:
        raise ValueError('Playlist identity is not unique')
    obj = cast(matches[0], 'IITUserPlaylist')
    if obj.Kind != 2 or not obj.Name.startswith('ITL4 '):
        raise ValueError('Refusing system or non-ITL4 playlist')
    return obj


def apply(app, action, root):
    kind = action.get('kind', 'snapshot')
    if kind in ('snapshot', 'add_files'):
        n.legacy.action(app, action, root)
        return dict(kind=kind, method_returned=True)
    result = dict(kind=kind, requested=action, method_returned=False)
    if kind == 'track_put':
        field = action['field']
        if field not in TRACK_FIELDS:
            raise ValueError('Not a permitted discovery field: ' + field)
        result['capability'] = declared('IITFileOrCDTrack', field, 4)
        obj = track(app, action['track_pid'])
        value = action['value']
        if field == 'Location':
            destination = n.scoped(value, root)
            if n.facts(destination)['sha256'] != action['location_sha256']:
                raise ValueError('New Location media hash mismatch')
            value = str(destination)
        if field.endswith('Date'):
            value = pywintypes.Time(datetime.datetime.fromisoformat(value))
        result['before_value'] = n.legacy.norm(getattr(obj, field))
        try:
            setattr(obj, field, value)
            result['method_returned'] = True
        except pywintypes.com_error as error:
            result['com_error'] = str(error)
            result['hresult'] = error.hresult
        result['after_value'] = n.legacy.norm(getattr(obj, field))
        result['requested_value_matched'] = result['after_value'] == n.legacy.norm(value)
        return result
    if kind in ('create_user_playlist', 'create_folder'):
        name = action['name']
        if not isinstance(name, str) or not name.startswith('ITL4 ') or len(name) > 120:
            raise ValueError('An ITL4-prefixed discovery name is required')
        if any(p.Name == name for p in n.legacy.items(app.LibrarySource.Playlists)):
            raise ValueError('Creation target already exists')
        method = 'CreateFolder' if kind == 'create_folder' else 'CreatePlaylist'
        result['capability'] = declared('IiTunes', method, 1)
        obj = getattr(app, method)(name)
        result['new_pid'] = valid_pid(n.legacy.pid(app, obj))
        result['method_returned'] = True
        result['actual_name'] = obj.Name
        user = cast(obj, 'IITUserPlaylist')
        result['actual_kind'] = user.Kind
        result['actual_special_kind'] = user.SpecialKind
        result['actual_smart'] = user.Smart
        parent = user.Parent
        result['actual_parent_pid'] = None if parent is None else n.legacy.pid(app, parent)
        return result
    if kind == 'playlist_add':
        obj = playlist(app, action['playlist_pid'], action['owned_playlist_pids'])
        if obj.Smart or obj.SpecialKind != 0:
            raise ValueError('Only ordinary manual playlist membership can be added')
        result['capability'] = declared('IITUserPlaylist', 'AddTrack', 1)
        wanted = action['track_pids']
        if len(wanted) != len(set(wanted)):
            raise ValueError('Duplicate requested tracks')
        current = {n.legacy.pid(app, t) for t in n.legacy.items(obj.Tracks)}
        if current.intersection(wanted):
            raise ValueError('Requested membership already exists')
        tracks = [track(app, pid) for pid in wanted]
        for t in tracks:
            obj.AddTrack(t)
        result['method_returned'] = True
        result['member_pids'] = [n.legacy.pid(app, t) for t in n.legacy.items(obj.Tracks)]
        return result
    if kind == 'playlist_parent':
        allowed = action['owned_playlist_pids']
        obj = playlist(app, action['playlist_pid'], allowed)
        parent_pid = action['parent_pid']
        parent = None if parent_pid is None else playlist(app, parent_pid, allowed)
        if parent_pid == action['playlist_pid']:
            raise ValueError('Refusing self-parent relation')
        if obj.Smart or obj.SpecialKind != 0:
            raise ValueError('Parent experiment moves only an ordinary manual playlist')
        if parent is not None:
            if parent_pid not in action['owned_folder_pids']:
                raise ValueError('Destination lacks a recorded native CreateFolder identity')
            # Pinned 12.13.10.3 CreateFolder (pa4-f1/f2): SpecialKind=4, Smart=True.
            if parent.SpecialKind != 4 or parent.Parent is not None:
                raise ValueError('Destination must be a recorded root folder with native SpecialKind=4')
            result['destination_classification'] = dict(kind=parent.Kind, special_kind=parent.SpecialKind, smart=parent.Smart)
        result['capability'] = declared('IITUserPlaylist', 'Parent', 4)
        previous = obj.Parent
        result['before_parent'] = None if previous is None else n.legacy.pid(app, previous)
        try:
            obj.Parent = parent
            result['method_returned'] = True
        except pywintypes.com_error as error:
            result['com_error'] = str(error)
            result['hresult'] = error.hresult
        actual = obj.Parent
        result['after_parent'] = None if actual is None else n.legacy.pid(app, actual)
        result['requested_value_matched'] = result['after_parent'] == parent_pid
        return result
    raise ValueError('Unsupported discovery action: ' + kind)
