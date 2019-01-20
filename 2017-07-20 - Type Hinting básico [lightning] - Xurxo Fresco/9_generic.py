#!env python3
from typing import TypeVar, Sequence, Callable

T = TypeVar('T')
T = TypeVar('T', int, float)
TTransorm = Callable[[T], T]
TList = Sequence[T]


def foreach(l: TList, func: TTransorm) -> TList:
    return [func(s) for s in l]


print(foreach(['f'], lambda x: x * x))
