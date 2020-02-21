"""REQUEST PROCESSING
Functions called from the manager, async
"""

from random import uniform
from .request_helpers import sleep_helper
from ..logger import log


async def process_request():
    log("Start of request processing (step 1)")

    sleep_time = uniform(0, 2)
    log(f"The request will sleep for {sleep_time} (step 2)")
    sleep_helper(sleep_time)

    log("End of request processing (step 6)")
