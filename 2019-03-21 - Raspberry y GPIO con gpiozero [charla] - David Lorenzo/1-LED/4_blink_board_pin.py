from gpiozero import LED

# Usamos la anotación BOARD para la numeración del pin
# El pin GPIO17 equivale al pin número 11 de RPi
led = LED("BOARD40")

# El LED parpadea, en segundo plano
led.blink()

input("Pulsa Enter para finalizar el parpadeo")

# Parar la ejecución cuando queramos:
led.off()
