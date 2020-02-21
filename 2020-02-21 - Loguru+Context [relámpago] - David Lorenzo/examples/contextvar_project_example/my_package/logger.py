"""LOGGER
A proper logger should be here. Instead we have a log function that simulates it.
context_request must be imported from where the requests are "created" to set the value (RequestID).
"""

from contextvars import ContextVar

__all__ = ("context_request", "log")

context_request = ContextVar("RequestID")
"""Context variable, set on the request source, and get on the logger"""


def log(msg):
    # TODO Fallback if cannot get context_request
    print(f"LOG [{context_request.get()}] - {msg}")
