class test_context_manager:
    def __enter__(self):
        print("Estoy entrando...")

    def __exit__(self, exc_type, exc_value, traceback):
        print("Salí del contexto!")
        
#with test_context_manager():
#    print("Estoy dentro del context manager")
