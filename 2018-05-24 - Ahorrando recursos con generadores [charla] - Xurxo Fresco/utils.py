import math


def print_and_return(x):
    print(x)
    return x

def is_prime(number):
    if number == 1:
        return True
    if number > 1:
        if number == 1:
            return True
        if number == 2:
            return True
        if number % 2 == 0:
            return False
        for current in range(3, int(math.sqrt(number) + 1), 2):
            if number % current == 0:
                return False
        return True
    return False

import psutil
import os
import sys
import time

# as in https://github.com/CoreyMSchafer/code_snippets/blob/master/mem_profile.py
def memory_usage_psutil():
    process = psutil.Process(os.getpid())
    mem = process.memory_info().rss / float(2 ** 20)
    return '{:.2f} MB'.format(mem)
