from gpiozero import LED, Button
from signal import pause

led = LED(21)
button = Button(4)

# Asignamos las funciones a las acciones del botón
# El método toggle sobre LED cambia el estado del led
button.when_pressed = led.toggle

# Mantenemos el programa pausado
# Las acciones del botón se procesan de fondo
# No necesario si lo ejecutamos desde intérprete
pause()
