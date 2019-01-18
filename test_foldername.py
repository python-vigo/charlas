"""
Basic tests to ensure folder names are properly formatted.
"""
from pathlib import Path
from datetime import datetime

import pytest


folder_names = [str(x) for x in Path('.').iterdir()
                if x.is_dir() and not str(x).startswith(('.', '_'))]


def test_date():
    """
    - ISO 8601 date format: Year-Month-Day. Ex: 2018-07-01
    """
    for name in folder_names:
        datetime.fromisoformat(name[:10])
