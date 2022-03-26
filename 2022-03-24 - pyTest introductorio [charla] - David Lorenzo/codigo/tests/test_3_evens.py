"""TEST 3
Work with lists in tests. Demonstrate how pytest shows which values are different when comparing expected vs result lists.
"""

import mycalculator
import pytest


def test_even_numbers():
    """Example 1: normal test with list assertion"""
    r = mycalculator.even_numbers_in_range(0, 10)
    expected_r = [0, 2, 4, 6, 8, 10]
    assert r == expected_r


@pytest.mark.skip("failing test")
def test_even_numbers_failing_missing_from_list():
    """Example 2: failing test because expecting less numbers;
    with skip mark (comment/remove skip mark to see it failing)"""
    r = mycalculator.even_numbers_in_range(0, 10)
    expected_r = [2, 4, 6, 8]
    assert r == expected_r


@pytest.mark.skip("failing test")
def test_even_numbers_failing_different_order():
    """Example 3: failing test because expected list has different order than result;
    with skip mark (comment/remove skip mark to see it failing)"""
    r = mycalculator.even_numbers_in_range(0, 10)
    expected_r = [2, 8, 0, 4, 10, 6]
    assert r == expected_r


def test_even_numbers_different_order_compare_sets():
    """Example 4: successful set with comparison of sets - order does not matter"""
    r = mycalculator.even_numbers_in_range(0, 10)
    expected_r = {2, 8, 0, 4, 10, 6}
    assert set(r) == expected_r
