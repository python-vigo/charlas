import os
from typing import Optional
from typing_extensions import Annotated, Literal

from pydantic import BaseSettings, Field, parse_obj_as

LogLevel = Literal["DEBUG", "INFO", "WARNING", "WARN", "ERROR", "CRITICAL", "FATAL"]


class AppSection(BaseSettings):
    """Configuration related to the Business logic or the application proper"""

    name: str = Field("globalapi", const=True)
    """Name of the application this module belongs to"""
    log_level: LogLevel = "INFO"
    """A standard log level name in uppercase"""
    log_visibility: Optional[dict]
    """Log namespace against its level"""
    slack_enabled: bool
    """Whether to sent alerts to Slack"""
    report_channel: Optional[str]
    """A Slack channel to report the CI summary"""
    ssm_enabled: bool = True
    """Whether SSM should be used, always True in live envs, but false in CI and local"""

    class Config(BaseSettings.Config):
        env_prefix = "APP_"


Settings = Annotated[
    Union[ProdSettings, TestSettings, LocalStackSettings], Field(discriminator="app_environment")
]


def get_settings(app_environment=None) -> Settings:
    the_env = app_environment or os.environ.get("APP_ENVIRONMENT")
    if the_env not in ["test", "ci", "prod", "live", "localstack"]:
        raise ValueError(f"Invalid App environment {the_env}")
    return parse_obj_as(Settings, {"app_environment": the_env})
