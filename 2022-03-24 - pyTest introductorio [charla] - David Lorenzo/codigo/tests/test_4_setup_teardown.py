# https://raw.githubusercontent.com/David-Lor/pytest-talk-examples/332162b0feada2c9b24b586edbcd3a8b2e9aac4e/images/setup_teardown_flow_functions.svg


def setup_module():
    print("Setup Module")


def teardown_module():
    print("Teardown Module")


def setup_function():
    print("Setup Function")


def teardown_function():
    print("Teardown Function")


def test_setup_teardown_1():
    print("Inside test #1 function")


def test_setup_teardown_2():
    print("Inside test #2 function")
