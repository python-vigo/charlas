"""TEST 1
Basic tests; parametrized tests
"""

import mycalculator
import pytest


def test_add_two_numbers():
    """Example 1: normal test, call a function and assert its result"""
    r = mycalculator.add(5, 2)
    assert r == 7


@pytest.mark.skip("failing test")
def test_add_two_numbers_bad_test():
    """Example 2: failing test, with skip mark (comment/remove skip mark to see it failing)"""
    r = mycalculator.add(5, 2)
    assert r == 9


def this_test_will_not_run():
    """Example 3: function that will not run because does not start with test_...
    Verify that the test is not listed with:
    pytest --collect-only tests/test_1_add.py
    """
    raise Exception("This should never run!")


@pytest.mark.parametrize("a, b, expected_r", [
    # Array notation:
    [5, 2, 7],
    [0, 0, 0],
    [7, 3, 10],

    # pytest.param notation:
    pytest.param(5, 2, 7, id="5+2=7"),
    pytest.param(0, 0, 0, id="0+0=0"),
    pytest.param(7, 3, 10, id="7+3=10"),
])
def test_add_two_numbers_parametrized(a, b, expected_r):
    """Example 4: test with parametrized parameters/scenarios (function inputs and expected output)"""
    r = mycalculator.add(a, b)
    assert r == expected_r
