use itl_rs::ItlFile;
use std::{env, fs, path::Path};

fn usage() -> ! {
    eprintln!("usage: harness INPUT OUTPUT [--set-title TITLE] [--set-artist ARTIST]");
    std::process::exit(2);
}

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() < 3 {
        usage();
    }

    let mut lib = ItlFile::open(Path::new(&args[1])).expect("open");
    println!("version={}", lib.version());
    println!("library_persistent_id={:016X}", lib.library_persistent_id());
    println!("tracks={}", lib.tracks().len());
    println!("playlists={}", lib.playlists().len());
    println!("albums={}", lib.albums().len());
    println!("artists={}", lib.artists().len());
    for (i, t) in lib.tracks().iter().enumerate() {
        println!(
            "track[{i}].id={} pid={:016X} title={:?} artist={:?} album={:?}",
            t.id(),
            t.persistent_id(),
            t.title(),
            t.artist(),
            t.album()
        );
    }
    for (i, p) in lib.playlists().iter().enumerate() {
        println!(
            "playlist[{i}].pid={:016X} title={:?} members={:?}",
            p.persistent_id(),
            p.title(),
            p.track_ids()
        );
    }

    let mut i = 3;
    while i < args.len() {
        if i + 1 >= args.len() {
            usage();
        }
        match args[i].as_str() {
            "--set-title" => {
                let value = &args[i + 1];
                let track = lib.tracks_mut().first_mut().expect("first track");
                track.set_title(value);
                println!("mutation.set_title={value:?}");
            }
            "--set-artist" => {
                let value = &args[i + 1];
                let track = lib.tracks_mut().first_mut().expect("first track");
                track.set_artist(value);
                println!("mutation.set_artist={value:?}");
            }
            _ => usage(),
        }
        i += 2;
    }

    let bytes = lib.to_bytes().expect("serialize");
    fs::write(&args[2], &bytes).expect("write");
    println!("output_bytes={}", bytes.len());
}
