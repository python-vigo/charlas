def add(a, b):
    return a + b


def _add_mod_break(a, b, c):
    """Demonstrate how modifying a function may break the tests, thus may break the application"""
    return a + b + c


def _add_mod_clean(a, b, c=None):
    """Demonstrate how the modification could be done without producing breaking changes"""
    if c is None:
        c = 0
    return a + b + c


def divide(a, b):
    return a / b


def even_numbers_in_range(start, end):
    """Get the even numbers on the given range (both ends inclusive). Return as list"""
    return [n for n in range(start, end+1) if n % 2 == 0]
