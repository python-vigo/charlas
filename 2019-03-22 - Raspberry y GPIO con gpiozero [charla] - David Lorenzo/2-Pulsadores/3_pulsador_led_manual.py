from gpiozero import LED, Button
from signal import pause

led = LED(21)
button = Button(4)


def cambiar_led():
    if led.value == 1:
        # LED encendido -> apagarlo
        led.value = 0
    else:
        # LED apagado -> encenderlo
        led.value = 1


# Asignamos las funciones a las acciones del botón
# En este caso lo ejecutamos cuando soltamos el botón
button.when_released = cambiar_led

# Mantenemos el programa pausado
# Las acciones del botón se procesan de fondo
# No necesario si lo ejecutamos desde intérprete
pause()
