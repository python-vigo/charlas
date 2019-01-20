
from typing import TypeVar, Sequence, Callable

T = TypeVar('T')
T = TypeVar('T', int, float)
TTransorm = Callable[[T], T]
TList = Sequence[T]


def foreach(l: TList, func: TTransorm) -> TList: ...