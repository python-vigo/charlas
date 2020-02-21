import asyncio
from .services.request_handler import handle_request
from .services.helpers import get_context
from .logger import logger


async def _run():
    logger.debug("App START")
    get_context()
    tasks = [handle_request() for _ in range(5)]
    await asyncio.gather(*tasks)
    logger.debug("App END")


def run():
    asyncio.run(_run())
