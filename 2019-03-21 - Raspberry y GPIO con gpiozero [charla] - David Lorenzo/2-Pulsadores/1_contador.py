from gpiozero import Button
from signal import pause

button = Button(4)
contador = 0


# Función que se ejecuta cuando el botón se pulsa
def btn_pulsado():
    # contador como variable global para que se actualice
    # desde dentro de la función
    global contador
    # sumamos +1 al contador
    contador += 1
    # y lo mostramos
    print("Contador:", contador)


# Asignamos las funciones a las acciones del botón
button.when_pressed = btn_pulsado
# button.when_released = btn_pulsado

# Mantenemos el programa pausado
# Las acciones del botón se procesan de fondo
# No necesario si lo ejecutamos desde intérprete
pause()
