from gpiozero import Button

button = Button(4)

print("Esperando a que pulses el botón...")

# El programa queda parado en este punto:
button.wait_for_press()
# Cuando se pulsa el botón, se continúa...

print("Botón pulsado! Hasta luego!")
