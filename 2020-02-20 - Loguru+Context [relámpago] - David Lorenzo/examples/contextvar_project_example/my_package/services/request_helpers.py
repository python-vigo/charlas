"""REQUEST HELPERS
Helper sync functions called from REQUEST PROCESSING
"""

from time import sleep
from ..logger import log


def sleep_helper(sleep_time):
    log("Start of sleep helper (step 3)")

    log(f"Sleeping for {sleep_time} seconds (step 4)")
    sleep(sleep_time)

    log("End of sleep helper (step 5)")
