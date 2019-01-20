#!env python3


class Person:
    # TODO: name: str
    def __init__(self, name) -> None:
        self.Name = name


#    @property
#    def Name(self):
#        return self._Name


def times(a: int, b: int) -> int:
    return a * b


t = times(Person("Ada Byron").Name, 4)
print(t)
