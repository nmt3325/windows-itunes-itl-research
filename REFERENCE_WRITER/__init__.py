"""Narrow fail-closed reference writer."""

from .writer import (
    ConversionRefused,
    WriterError,
    atomic_write_new,
    convert_version,
    encode_envelope,
)

__all__ = [
    "ConversionRefused",
    "WriterError",
    "atomic_write_new",
    "convert_version",
    "encode_envelope",
]
