from gpiozero import LED, PWMLED

power = LED(35)
activity = PWMLED(47)

# Los LED parpadean, en segundo plano
power.blink(on_time=0.5, off_time=0.5)
# activity.blink(on_time=0.1, off_time=0.1)
activity.pulse(fade_in_time=1, fade_out_time=2)

# Parar la ejecución cuando queramos:
input("Pulsa Enter para finalizar")
power.off()
activity.off()
