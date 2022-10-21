import inspect
import logging
from typing import Any, Callable, Dict, Optional, Union
from functools import wraps

import boto3
from aws_lambda_powertools.event_handler import APIGatewayHttpResolver
from aws_lambda_powertools.event_handler.api_gateway import Response
from aws_lambda_powertools.middleware_factory import lambda_handler_decorator
from aws_lambda_powertools.utilities.parser import event_parser
from aws_lambda_powertools.utilities.typing import LambdaContext
from structlog import contextvars, get_logger

from . import config, event_models
from .aux import EmptyEvent, dhms, response_builder, update_settings_from_ssm
from .exception_utils import alerter, gather_traceback, msg_builder, returner, func_clean_path
from .processor import process_record

logger = get_logger(name=__name__)
# cached artifacts
CONFIG = config.get_settings()
SSM = boto3.client("ssm", region_name=CONFIG.aws.region_name, config=**CONFIG.ssm.dict())
update_settings_from_ssm(SSM, CONFIG)

SQS = boto3.resource("sqs", region_name=CONF.aws.region_name)
QUEUE = SQS.Queue(SQS.get_queue_by_name(QueueName=CONFIG.app.queue_name).url)


default_params = SSM_CLIENT.get_parameters_by_path(Path="/default")
update_settings_from_ssm(ssm_client, CONFIG)
DB_CLIENT = DbClient(**CONFIG.db.dict_no_secrets())


## SQS event Batch entripoint

# project/service/worker_entrypoint.py
@event_parser(model=event_models.CoolQueueEvent)
def worker_main(event: event_models.CoolEvent, _context: LambdaContext) -> list:
    batch_size = len(event.Records)
    result_list = []
    for index, record in enumerate(event.Records):
        result_list += process_record(record)
    return result_list


#### Routing example

MAIN_ROUTE = "/integration/"
ENDPOINT_ONE = "/endpoint/<identifier>"
router = APIGatewayHttpResolver(strip_prefixes=[MAIN_ROUTE])

def api_entrypoint_or_handler(event: dict, _context: LambdaContext) -> Dict[str, Any]:
    """Entrypoint for all crud operations"""
    contextvars.bindcontextvars(
        RequestId=_context.aws_request_id,
        trace_id=event.trace_id,
        identifier=event.id
    )
    return router.resolve(event, _context)

@router.get(ENDPOINT_ONE)
def retrieve_entity(identifier) -> Union[str, Response]:
    """Retrieve entity with given identifer"""
    logger.info(inspect.currentframe().f_code.co_name)
    # Do stuff
    num = 20
    value = 63.55 # seconds
    logger.info(f"Download {num} images took {dhms(value)}", duration_s=value)
    # INFO event=Download 20 images took 1m3s550ms duration_s=63.550

    msg = "Item not found"
    logger.error(msg)
    return response_builder(msg, 404)

## Lambda middleware, catches empty event

@lambda_handler_decorator
def preparation(
        handler: Callable, event: dict, ctx: LambdaContext, prepare: Optional[Callable] = None
) -> Callable:
    if prepare:
        prepare(handler.__module__, CONFIG.app.log_level)
    logger.info(f"Current version is {handler.__module__.__version}")
    if not event:
        raise EmptyEvent(f"Received and empty event for lambda `{ctx.aws_request_id}`")
    response = handler(event, ctx)
    return response


def custom_exception_handler(extenal_logger = None):
    def decorator(function_to_handle: Callable):
        """Exception handler for lambdas"""
        @wraps(function_to_handle)
        def wrapper(*args, **kwargs):
            event, ctx, *_ = args
            logger = logging.getLogger(func_clean_path(function_to_handle))
            try:
                return function_to_handle(*args, **kwargs)
            except Exception as exc:  # pylint: disable=broad-except
                exc_type, stacktrace = gather_traceback(exc)
                msg, status, debug, extra = msg_builder(exc, args, kwargs)
                logger.error(msg, debug=debug, exc_type=exc_type, exception=stacktrace)
                alerter(msg, function_to_handle, ctx, (exc, exc_type, stacktrace))
                return returner(
                    msg, status, function_to_handle, ctx, (exc, exc_type, stacktrace), extra
                )
        return wrapper
    return decorator
