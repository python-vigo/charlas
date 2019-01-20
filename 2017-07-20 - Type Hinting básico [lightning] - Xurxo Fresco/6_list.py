#!env python3
from typing import List


def scale(scalar: float, vector: List[float]) -> List[float]:
    return [scalar * num for num in vector]


print(scale(3, [1, '3', 3]))
