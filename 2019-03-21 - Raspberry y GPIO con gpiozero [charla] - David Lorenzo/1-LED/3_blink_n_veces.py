from gpiozero import LED
from signal import pause

led = LED(21)

parpadeos = int(input("¿Cuántos parpadeos? "))

# El LED parpadea, en segundo plano (1 parpadeo por segundo)
led.blink(on_time=0.5, off_time=0.5, n=parpadeos)

# Mantenemos el programa pausado
# Las acciones del botón se procesan de fondo
# No necesario si lo ejecutamos desde intérprete
# Finalizar con Ctrl+C
pause()
