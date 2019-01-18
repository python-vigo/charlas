from machine import Pin
from utime import sleep

LED = Pin(2, Pin.OUT)
state = False

while True:
	LED.value(state)
	state = not state
	sleep(1)

