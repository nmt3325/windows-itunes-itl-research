"""Independent reference reader for observed Windows iTunes ITL files."""

from .core import (
    Envelope,
    FormatError,
    Record,
    ReferenceError,
    ReferenceLibrary,
    Section,
    SUPPORTED_PROFILES,
    UnsupportedError,
    decode_envelope,
    decode_envelope_bytes,
    detect,
    detect_bytes,
    parse_sections,
)

__all__ = [
    "Envelope",
    "FormatError",
    "Record",
    "ReferenceError",
    "ReferenceLibrary",
    "Section",
    "SUPPORTED_PROFILES",
    "UnsupportedError",
    "decode_envelope",
    "decode_envelope_bytes",
    "detect",
    "detect_bytes",
    "parse_sections",
]
