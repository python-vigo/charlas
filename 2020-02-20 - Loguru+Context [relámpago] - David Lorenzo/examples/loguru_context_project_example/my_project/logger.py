import sys
from loguru import logger

logger.remove()
logger.add(sys.stderr, level="DEBUG", format="{message} ({extra[context_id]})")


def _patch_func(record):
    """Patch the logger to set extra.context_id to a generic value if not exists
    (this happens when logging outside of the request_handler)
    """
    if not record["extra"] or not record["extra"].get("context_id"):
        record["extra"]["context_id"] = "System"


logger = logger.patch(_patch_func)
