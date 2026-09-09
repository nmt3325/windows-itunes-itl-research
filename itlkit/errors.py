"""Explicit format and unsupported-operation errors (never silent repair)."""
class ITLError(ValueError):
    """Base exception for invalid input or an unsafe/unsupported request."""

class FormatError(ITLError):
    def __init__(self, message: str, offset: int | None = None):
        self.offset = offset
        super().__init__(message + (f" at 0x{offset:x}" if offset is not None else ""))

class UnsupportedError(ITLError):
    """The byte layout can be preserved, but the requested semantics are unknown."""