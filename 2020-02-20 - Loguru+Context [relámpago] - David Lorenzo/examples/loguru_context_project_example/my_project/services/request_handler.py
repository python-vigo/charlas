import uuid
import random
from .helpers import async_sleep, sync_sleep, get_context
from ..logger import logger

async def handle_request():
    with logger.contextualize(context_id=str(uuid.uuid4())):
        logger.debug("Request Handle START")
        await async_sleep(random.uniform(0, 2))
        sync_sleep(random.uniform(0, 2))
        get_context()
        logger.debug("Request Handle ENDED")
