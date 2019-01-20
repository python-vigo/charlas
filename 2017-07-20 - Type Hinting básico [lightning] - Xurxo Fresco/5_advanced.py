#!env python3


from enum import Enum


class Sex(Enum):
    M = 'M'
    F = 'F'


class Person:
    # TODO: sex:Sex
    def __init__(self, name: str, sex) -> None:
        self.Name = name
        self.Sex = sex


def showSex(person: Person):
    print(person.Sex)


p = Person("Jean E. Sammet", 'J')
showSex(p)
