from gpiozero import PWMLED

led = PWMLED(21)

led.pulse(
    fade_in_time=0.5,  # tiempo hasta encenderse
    fade_out_time=2,  # tiempo hasta apagarse
    background=False  # ejecutar en primer plano
)
