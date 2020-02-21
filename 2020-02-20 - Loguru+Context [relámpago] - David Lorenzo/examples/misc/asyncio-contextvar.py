"""ASYNCIO ContextVars
ContextVars can be used to pass context-like variables to chained functions transparently, without using function args/kwargs.
Might be useful for logging sync/async services that run a chain of functions to handle a request (e.g. a web server, a Tg bot).
https://stackoverflow.com/questions/30596484/python-asyncio-context
"""

import time
import asyncio
import contextvars


request_id = contextvars.ContextVar('ID of the request')
"""ContextVar request_id save the 'id' of the chain of requests, along multiple chained coroutines"""


def debug(msg):
    """Should be easily integrable in loggers
    (only need the ContextVar to be imported from where the request starts, and from a logger handling function)
    """
    print(f"DEBUG [{request_id.get()}] - {msg}")


def _inner_sync_routine():
    """Sync functions can also get contextvars. Fully sync Python code can use contextvars!
    """
    debug("Started inner_sync_routine")
    time.sleep(0.3)
    debug("Ended inner_sync_routine")


async def _inner_routine():
    """Inner coroutine, called from the main task runner.
    Shall be able to get the contextvar created on the main task runner.
    """
    debug("Started inner_routine")
    await asyncio.sleep(1)
    _inner_sync_routine()
    debug("Ended inner_routine")


async def task_run(task_id):
    """Main task runner, where the contextvar is set
    """
    request_id.set(f"Task#{task_id}")
    debug("Started task_run")
    await _inner_routine()
    debug("Ended task_run")


async def main():
    """Create n tasks and run them all (gather)
    """
    tasks = [asyncio.create_task(task_run(task_id)) for task_id in range(5)]
    await asyncio.gather(*tasks)


if __name__ == "__main__":
    asyncio.run(main())
