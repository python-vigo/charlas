import asyncio
import time
from ..logger import logger


async def async_sleep(sleep_time):
    logger.debug(f"Async Sleep for {sleep_time} START")
    await asyncio.sleep(sleep_time)
    logger.debug("Async Sleep END")


def sync_sleep(sleep_time):
    logger.debug(f"Sync Sleep for {sleep_time} START")
    time.sleep(sleep_time)
    logger.debug("Sync Sleep END")


def get_context():
    """Useful to get the current context value from arbitrary places.
    Not very canonical though (unexported import from loguru)
    """
    # TODO Better way to access loguru context?
    from loguru._logger import context
    logger.debug("Current context is:", context.get("context_id"))
