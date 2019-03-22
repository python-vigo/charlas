from gpiozero import LED
from signal import pause

led = LED(21)

# Personalizar el tiempo que permanece encendido y apagado
# 0.5 segundos encendido, 0.25 segundos apagado
led.blink(on_time=0.5, off_time=0.25)

# led.blink() por defecto usa on_time=1 y off_time=1
# El led se enciende o apaga cada segundo (1 parpadeo cada 2 segundos)

# Mantenemos el programa pausado
# Las acciones del botón se procesan de fondo
# No necesario si lo ejecutamos desde intérprete
# Finalizar con Ctrl+C
pause()
