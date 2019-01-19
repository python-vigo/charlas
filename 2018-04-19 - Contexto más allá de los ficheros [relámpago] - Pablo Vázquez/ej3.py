from contextlib import ContextDecorator
class test_context_manager(ContextDecorator):
    def __enter__(self):
        print("1. Estoy entrando...")

    def __exit__(self, exc_type, exc_value, traceback):
        print("3. Salí del contexto!")
    
@test_context_manager()
def mi_funcion_decorada():
    print("2. Estoy dentro del context manager")
    
#mi_funcion_decorada()
