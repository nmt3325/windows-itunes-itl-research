import dataclasses, inspect, json
from pathlib import Path
import sys
ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT))
import itlkit
from itlkit import playlist_models as pm, library as lib, operations as ops

print("itlkit public:", sorted(n for n in dir(itlkit) if not n.startswith('_')))
print()
for cls in (pm.Diagnostic, pm.RawSpan, pm.WireField, pm.SmartRule, pm.SmartTree,
            pm.MetadataOccurrence, pm.EntryModel, pm.ParentEdge, pm.PlaylistModel,
            pm.SectionModel, pm.PlaylistDocument):
    print(cls.__name__, [f.name for f in dataclasses.fields(cls)])
print()
print("inspect_playlists", inspect.signature(pm.inspect_playlists))
print("inspect_playlist_payload", inspect.signature(pm.inspect_playlist_payload))
print("parse_smart_rules", inspect.signature(pm.parse_smart_rules))
print("models_json", inspect.signature(pm.models_json))
print()
print("library public:", sorted(n for n in dir(lib) if not n.startswith('_')))
print("Library methods:", sorted(n for n in dir(lib.Library) if not n.startswith('_')))
for n in sorted(n for n in dir(lib.Library) if not n.startswith('_')):
    a = getattr(lib.Library, n)
    if callable(a):
        try:
            print("   Library." + n, inspect.signature(a))
        except (TypeError, ValueError):
            print("   Library." + n, "<no sig>")
print("Playlist methods:", sorted(n for n in dir(lib.Playlist) if not n.startswith('_')))
print("operations public:", sorted(n for n in dir(ops) if not n.startswith('_')))
print("require_plain", inspect.signature(ops.require_plain))
