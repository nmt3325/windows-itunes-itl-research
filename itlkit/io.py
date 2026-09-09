"""Non-overwriting output helpers. The input is never modified implicitly."""
from pathlib import Path

def write_new(path: Path, data: bytes) -> None:
    # Exclusive creation protects inputs, existing outputs, and hard-link aliases.
    with path.open('xb') as stream:
        stream.write(data)