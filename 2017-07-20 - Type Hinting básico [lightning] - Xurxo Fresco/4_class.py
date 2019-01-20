#!env python3


class Person:
    def __init__(self, name: str) -> None:
        self.Name = name


class Pet:
    def __init__(self, name: str) -> None:
        self.Name = name


def showName(p):
    # TODO: p:Person for IDE hint
    print(p.Name)


showName(Person("Grace Murray Hopper"))
showName(Pet("Scooby"))
