# Ejecutar como root con sudo

from gpiozero import Button, LED
from subprocess import check_call
from signal import pause

# Boton de apagado; debe mantenerse pulsado 3 segundos
shutdown_btn = Button(3, hold_time=3)
# LED opcional para saber que todo va bien
led = LED(21)


# Funcion que se ejecuta cuando pulsamos el boton
def shutdown():
    # Parpadear el LED mas rapido mientras se esta apagando
    led.blink(on_time=0.1, off_time=0.1)
    check_call(['sudo', 'poweroff'])


# Parpadear el LED opcional para saber que
# todo esta funcionando bien
led.blink(on_time=0.5, off_time=0.5)
# Asignar la funcion shutdown al mantener el boton pulsado
shutdown_btn.when_held = shutdown

# Mantener el programa pausado
pause()
