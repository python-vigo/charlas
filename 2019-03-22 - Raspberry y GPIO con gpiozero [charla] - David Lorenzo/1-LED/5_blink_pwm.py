from gpiozero import PWMLED
from time import sleep

led = PWMLED(21)

# Parar la ejecución con Ctrl+C
while True:
    led.value = 0  # apagado
    sleep(0.5)
    led.value = 0.25
    sleep(0.5)
    led.value = 0.5  # 50%
    sleep(0.5)
    led.value = 0.75  # 75%
    sleep(0.5)
    led.value = 1  # 100%
    sleep(0.5)
