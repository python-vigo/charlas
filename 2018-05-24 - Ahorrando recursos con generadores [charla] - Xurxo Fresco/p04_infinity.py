import random

from p02_generator import fibo

n = 0
f = fibo()
while n < random.sample(1000):
    next(f)
    n += 1
