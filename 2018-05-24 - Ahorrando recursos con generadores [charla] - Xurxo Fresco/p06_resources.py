# from https://github.com/CoreyMSchafer/code_snippets/tree/master/Generators

import random
import time

from utils import memory_usage_psutil

names = ['John', 'Corey', 'Adam', 'Steve', 'Rick', 'Thomas']
majors = ['Math', 'Engineering', 'CompSci', 'Arts', 'Business']

print('Memory (Before): {}Mb'.format(memory_usage_psutil()))


def people_list(num_people):
    result = []
    for i in range(num_people):
        person = {
            'id': i,
            'name': random.choice(names),
            'major': random.choice(majors)
        }
        result.append(person)
    return result


def people_generator(num_people):
    for i in range(num_people):
        person = {
            'id': i,
            'name': random.choice(names),
            'major': random.choice(majors)
        }
        yield person


f = open("people.txt", "w")
t1 = time.clock()
# people = people_list(500000)
people = people_generator(500000)
f.writelines((p['major'] for p in people))
t2 = time.clock()

print('Memory (After) : {}Mb'.format(memory_usage_psutil()))
print('Took {} Seconds'.format(t2 - t1))
