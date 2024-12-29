import boto3
import pytest
from moto import mock_dynamodb, mock_sqs, mock_ssm

from .dyno_models import LocalDynamoDB


@pytest.fixture(scope="function", name="mocked_sqs")
def mocking_sqs(test_settings):
    with mock_sqs():
        client = boto3.resource("sqs", region_name=test_settings.aws.region)
        queue_name = f"{test_settings.queue.prefix}-{test_settings.app.queue_name}"
        queue = client.create_queue(QueueName=queue_name)
        yield queue


@pytest.fixture(scope="function")
def test_dyno(test_settings):
    with mock_dynamodb():
        LocalDynamoDB.Meta.region = test_settings.aws.region
        LocalDynamoDB.Meta.table_name = test_settings.dyno.table_name
        LocalDynamoDB.create_table()
        yield LocalDynamoDB  # we return the table
        LocalDynamoDB.delete_table()


@pytest.fixture(scope="session", autouse=True)
def mocked_ssm():
    """SSM is mocked globally"""
    with mock_ssm():
        yield
