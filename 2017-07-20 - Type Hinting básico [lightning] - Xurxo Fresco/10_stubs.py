#!env python3

def foreach(l, func):
    return [func(s) for s in l]


print(foreach(['f'], lambda x: x * x))
