"""Semantic comparison using the independent parser."""

from .diff import semantic_diff, semantic_diff_bytes, semantic_diff_libraries

__all__ = ["semantic_diff", "semantic_diff_bytes", "semantic_diff_libraries"]
