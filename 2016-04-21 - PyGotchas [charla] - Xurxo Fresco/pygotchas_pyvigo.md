% python gotchas
% Xurxo Fresco - @xurxof
% Python Vigo, Abril 2016

# Notas

##
Wat/Gotcha: casos extremos y contraituitivos

Deberíamos juzgar un lenguaje por sus gotchas?



# Precedencia de operadores


## Precedencia de operadores

~~~~~~~ 
>>> False == (False in [False])
... False

>>> (False == False) in [False]
... False

>>> False == False in [False]
... ?
~~~~~~~ 
## Precedencia de operadores
~~~~~~~ 
>>> False == (False in [False])
... False

>>> (False == False) in [False]
... False

>>> False == False in [False]
... True
~~~~~~~
## Precedencia de operadores
~~~~~~~ 
>>> False == False in [False]
True

- `in` es un operador logico
- Todos los operadores lógicos tiene la misma precedencia
- Las operaciones del tipo 1<a<3 se evaluan como 1<a and a<2

>>> False == False and False in [False]
True
~~~~~~~ 

# Diccionarios
## Diccionarios
~~~~~~~ 
>>> data = {
...     1: 'one',
...     '1': 'two',
...     True: 'true',
... }

>>> data

?
~~~~~~~ 
## Diccionarios
~~~~~~~ 
>>> data = {
...     1: 'one',
...     '1': 'two',
...     True: 'true',
... }

>>> data

{1: 'true', '1': 'two'}
~~~~~~~ 
 "The Boolean type is a subtype of the integer type, and Boolean values behave like the values 0 and 1"
 
 
# Is
## Is
~~~~~~~ 
>>> a = 256
>>> b = 256
>>> a is b
True
~~~~~~~ 
## Is
~~~~~~~ 
>>> a = 257
>>> b = 257
>>> a is b
False
~~~~~~~ 
## Is
~~~~~~~ 
>>> a = 257
>>> b = 257
>>> a is b
False

>>> a = 257; b = 257
>>> a is b
?
~~~~~~~ 
## Is
~~~~~~~ 
>>> a = 257
>>> b = 257
>>> a is b
False

>>> a = 257; b = 257
>>> a is b
True
~~~~~~~ 
## Is
~~~~~~~ 
>>> code_obj_a = compile (source="a = 257", filename="", mode="exec")

>>> code_obj_a.co_consts
(257,None)
~~~~~~~ 
## Is
~~~~~~~ 
>>> code_obj_a = compile (source="a = 257; b = 257", filename="", mode="exec") 

>>> code_obj_a.co_consts
(257,None)

~~~~~~~ 
## Is
~~~~~~~ 
# ver:
http://www.laurentluce.com/posts/python-integer-objects-implementation/

~~~~~~~ 
# Argumentos por defecto
~~~~~~~ 
>>> def foo(l=[]):
...     l.append('cat')
...     return l


>>> foo()
# ?

>>> foo()
# ?
~~~~~~~ 
## Argumentos por defecto
~~~~~~~ 
>>> def foo(l=[]):
...     l.append('cat')
...     return l


>>> foo()
['cat']

>>> foo()
['cat', 'cat']

# Parece que l=[] se ejectua sólo una vez (cuando definimos la función).
# Si es así entonces...
~~~~~~~ 
## Argumentos por defecto
~~~~~~~ 
>> def bar(l=[]):
...     print (locals())
...     l = ['cat']
...     return l
...

>>> bar()
# ? {'l': []}
# ? ['cat']

>>> bar()
# ? {'l': ['cat']}
# ? ['cat']
~~~~~~~ 
## Argumentos por defecto
~~~~~~~ 
>>> def bar(l=[]):
...     print (locals())
...     l = ['cat']
...     return l
...

>>> bar()
{'l': []}
['cat']

>>> bar()
{'l': []}
['cat']
~~~~~~~ 
## Argumentos por defecto
~~~~~~~ 
>>> def foo(l=[]):
...     l.append('cat')
...     return l
...

>>> foo.__defaults__ # foo.func_defaults en Py 2
(['cat'],)

>>> foo.__defaults__[0].append('dragon')
>>> foo.__defaults__
(['cat', 'dragon'],)

>>> foo()
['cat', 'dragon', 'cat']
~~~~~~~ 
## Argumentos por defecto
~~~~~~~ 
>>> def bar(l=[]):
...     print locals()
...     l = ['cat']
...     return l


>>> bar.__defaults__
([],)

>>> bar()
{'l': []} ## locals
['cat']

>>> bar.__defaults__
([],)

# Al reasignar 'l' a otra lista, no se modifica la lista contenida en __defaults__
# por eso funciona lo siguiente:

def append_to(element, to=None):
    if to is None:
        to = []
    to.append(element)
    return to
~~~~~~~ 
# Variables de clase
~~~~~~~ 
class AAA(object):
    x = 1

class BBB(AAA):
    pass

class CCC(AAA):
    pass

# AAA: {'x': 1}, BBB: {}, CCC: {}
>>> print AAA.x, BBB.x, CCC.x
1 1 1
# AAA: {'x': 1}, BBB: {'x': 2}, CCC: {}
>>> BBB.x = 2
>>> print AAA.x, BBB.x, CCC.x
1 2 1
# AAA: {'x': 3}, BBB: {'x': 2}, CCC: {}
>>> AAA.x = 3
>>> print AAA.x, BBB.x, CCC.x
3 2 3
~~~~~~~ 
## Variables de clase 
~~~~~~~ 
class AAA(object):
    x = 1

class BBB(AAA):
    pass

class CCC(AAA):
    pass


>>> print AAA.x, BBB.x, CCC.x
?

>>> BBB.x = 2

>>> print AAA.x, BBB.x, CCC.x
?


>>> AAA.x = 3

>>> print AAA.x, BBB.x, CCC.x
?
~~~~~~~ 
## Variables de clase
~~~~~~~ 
class AAA(object):
    x = 1

class BBB(AAA):
    pass

class CCC(AAA):
    pass

# AAA: {'x': 1}, BBB: {}, CCC: {}
>>> print AAA.x, BBB.x, CCC.x
1 1 1

>>> BBB.x = 2
# AAA: {'x': 1}, BBB: {'x': 2}, CCC: {}
>>> print AAA.x, BBB.x, CCC.x
1 2 1


>>> AAA.x = 3
# AAA: {'x': 3}, BBB: {'x': 2}, CCC: {}
>>> print AAA.x, BBB.x, CCC.x
3 2 3
~~~~~~~ 
# Mutability

## Mutability
~~~~~~~ 
>>> a = ([42],)
>>> a[0] += [43, 44]
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: 'tuple' object does not support item assignment
~~~~~~~ 
## Mutability
~~~~~~~ 
>>> a = ([42],)
>>> a[0] += [43, 44]
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: 'tuple' object does not support item assignment

>>> a
([42, 43, 44],)
~~~~~~~ 
## Mutability
~~~~~~~ 
>>> a = ([42],)
>>> a[0] += [43, 44]
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: 'tuple' object does not support item assignment

>>> a
([42, 43, 44],)


>>> a = ([42],)
>>> b = a[0]
>>> b += [43, 44]

>>> a
([42, 43, 44],)
~~~~~~~ 

# all and emptiness

## all and emptiness
~~~~~~~
>>> all([])
True




~~~~~~~


## all and emptiness
~~~~~~~
>>> all([])
True
>>> all([[]])
False


~~~~~~~


## all and emptiness
~~~~~~~
>>> all([])
True
>>> all([[]])
False
>>> all([[[]]])
True
~~~~~~~

## all and emptiness
~~~~~~~
>>> all([]) 		## por definicion de la funcion
True
>>> all([[]])
False
>>> all([[[]]])
True
~~~~~~~


## all and emptiness
~~~~~~~
>>> all([]) 		## por definicion de la funcion
True
>>> all([[]])		## bool([]) -> False
False
>>> all([[[]]])     
True
~~~~~~~

## all and emptiness
~~~~~~~
>>> all([]) 		## por definicion de la funcion
True
>>> all([[]])		## [[]] -> [False]
False
>>> all([[[]]])     
True
~~~~~~~



## all and emptiness
~~~~~~~
>>> all([]) 		## por definicion de la funcion
True
>>> all([[]])		## [[]] -> [False]
False
>>> all([[[]]])     ## bool ( [False]) -> True
True
~~~~~~~


## all and emptiness
~~~~~~~
>>> all([]) 		## por definicion de la funcion
True
>>> all([[]])		## [[]] -> [False]
False
>>> all([[[]]])     ## [[[]]] -> [[False]] -> [True] 
True
~~~~~~~

# nan

## nan
~~~~~~~
>>> x = float("nan")
>>> len({x, x, float(x), float(x), float("nan"), float("nan")})
?
>>> len({x, float(x), float("nan")})
?
~~~~~~~


## nan
~~~~~~~
>>> x = float("nan")
>>> len({x, x, float(x), float(x), float("nan"), float("nan")})
3
>>> len({x, float(x), float("nan")})
2
~~~~~~~


## nan
~~~~~~~
>>> x = float("nan")
>>> {x, x, float(x), float(x), float("nan"), float("nan")}
set([nan, nan, nan])
>>> {x, float(x), float("nan")}
set([nan, nan])
~~~~~~~

## nan
~~~~~~~
>>> x is x
True
>>> float(x)==float(x)
True
>>> float(x)==x
True
>>> float("nan") == float("nan")
False
~~~~~~~





# Iteradores

## Iteradores
~~~~~~~
>>> a = 2, 1, 3
>>> sorted(a) == sorted(a)
?
>>> reversed(a) == reversed(a)
?
~~~~~~~


## Iteradores
~~~~~~~
>>> a = 2, 1, 3
>>> sorted(a) == sorted(a)
True
>>> reversed(a) == reversed(a)
False
~~~~~~~



# isinstance & metaclases

## 
~~~~~~~
>>> isinstance (type, object)
>>> ?
>>> isinstance (object, type)
>>> ?

~~~~~~~


## isinstance & metaclases
~~~~~~~
>>> isinstance (type, object)
>>> true
>>> isinstance (object, type)
>>> true

~~~~~~~
# Referencias

## Referencias

http://stackoverflow.com/questions/530530/python-2-x-gotchas-and-landmines

https://www.youtube.com/watch?v=sH4XF6pKKmk

https://github.com/cosmologicon/pywat

https://docs.python.org/3/faq/programming.html#why-does-a-tuple-i-item-raise-an-exception-when-the-addition-works

