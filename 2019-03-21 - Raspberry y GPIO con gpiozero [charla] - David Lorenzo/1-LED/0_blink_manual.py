from gpiozero import LED
from time import sleep

led = LED(21)

# Parar la ejecución con Ctrl+C
while True:
    led.on()
    sleep(1)
    led.off()
    sleep(1)
