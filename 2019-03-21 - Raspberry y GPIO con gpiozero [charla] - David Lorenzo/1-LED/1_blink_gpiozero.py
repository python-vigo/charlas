from gpiozero import LED

led = LED(21)

# El LED parpadea, en segundo plano
led.blink()

# Parar la ejecución cuando queramos:
input("Pulsa Enter para finalizar")
led.off()
