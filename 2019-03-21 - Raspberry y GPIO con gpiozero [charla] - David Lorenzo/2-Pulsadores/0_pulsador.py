from gpiozero import Button
from signal import pause

button = Button(4)


# Función que se ejecuta cuando el botón se pulsa
def btn_pulsado():
    print("El botón se ha pulsado")


# Función que se ejecuta cuando el botón se suelta
def btn_soltado():
    print("El botón se ha soltado")


# Asignamos las funciones a las acciones del botón
button.when_pressed = btn_pulsado
button.when_released = btn_soltado

# Mantenemos el programa pausado
# Las acciones del botón se procesan de fondo
# No necesario si lo ejecutamos desde intérprete
# Finalizar con Ctrl+C
pause()
