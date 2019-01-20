#!env python3
from collections import namedtuple
import typing

Person = namedtuple('Person', ['Name', 'Age'])
# Person = typing.NamedTuple('Person', [('Name', str), ('Age', float)])

person = Person(84.4, "Hedy Lamarr")
