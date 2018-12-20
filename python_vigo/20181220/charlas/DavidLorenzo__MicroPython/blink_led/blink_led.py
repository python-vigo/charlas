from machine import Pin
from utime import sleep

LED = Pin(2, Pin.OUT)

def blink():
	state = False
	while True:
		try:
			LED.value(state)
			state = not state
			sleep(1)
		except KeyboardInterrupt:
			break
