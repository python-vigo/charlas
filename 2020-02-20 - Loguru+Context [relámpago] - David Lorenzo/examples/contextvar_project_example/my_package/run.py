import asyncio
from .services.request_manager import new_request


async def _async_run():
    tasks = [new_request() for _ in range(5)]
    await asyncio.gather(*tasks)


def run():
    asyncio.run(_async_run())
