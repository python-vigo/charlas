#!env python3
from typing import List, Callable

StrTransorm = Callable[[str], str]


def foreach(l: List[int], func: StrTransorm) -> List[str]:
    # def foreach(l: List[int], func: Callable[[str], str]) -> List[str]:
    return [func(s) for s in l]


print(foreach([1], str.lower))
