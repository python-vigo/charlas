
from contextlib import contextmanager

@contextmanager
def tag(name):
    print("1. <%s>" % name)
    yield
    print("3. </%s>" % name)

# with tag('mi_etiqueta'):
#    print('2. estoy dentroooo')

