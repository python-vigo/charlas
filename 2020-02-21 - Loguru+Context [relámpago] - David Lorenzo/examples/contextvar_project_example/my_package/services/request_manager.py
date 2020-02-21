"""REQUEST MANAGER
Where the requests are created
"""

from uuid import uuid4
from .request_processing import process_request
from ..logger import log, context_request


async def new_request():
    request_id = str(uuid4())
    context_request.set(request_id)

    log("New request created (step 0)")

    await process_request()

    log("Request ended (step 7)")
