"""TEST 2
Tests where we can have exceptions, and where we expect exceptions.
"""

import mycalculator
import pytest


def test_divide_two_numbers():
    """Example 1: normal test, call a function and assert its result"""
    assert mycalculator.divide(10, 2) == 5


@pytest.mark.skip("failing test")
def test_divide_by_zero_failing():
    """Example 2: failing test due to raised exception, with skip mark (comment/remove skip mark to see it failing)"""
    assert mycalculator.divide(10, 0) == 0


def test_divide_by_zero_expect_exception():
    """Example 3: expect a function call from raising an exception"""
    with pytest.raises(ZeroDivisionError):
        mycalculator.divide(10, 0)


@pytest.mark.skip("failing test")
def test_divide_by_zero_expected_exception_failing():
    """Example 4: failing test because the function call expects an exception but runs without exception;
    with skip mark (comment/remove skip mark to see it failing)"""
    with pytest.raises(ZeroDivisionError):
        mycalculator.divide(10, 5)


@pytest.mark.parametrize("a, b, expected_r, expected_exception", [
    pytest.param(5, 1, 5, None, id="5/1=5"),
    pytest.param(10, 5, 2, None, id="10/2=5"),
    pytest.param(10, 0, None, ZeroDivisionError, id="10/0=ZeroDivisionError"),
    pytest.param("NotANumber", 5, None, TypeError, id="string/5=TypeError"),
])
def test_divide_parametrized(a, b, expected_r, expected_exception):
    """Example 5: complete parametrized test with expected result and expected exception"""
    if expected_exception:
        with pytest.raises(expected_exception):
            mycalculator.divide(a, b)

    else:
        r = mycalculator.divide(a, b)
        assert r == expected_r
