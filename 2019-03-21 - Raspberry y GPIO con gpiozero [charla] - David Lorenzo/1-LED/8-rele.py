from gpiozero import OutputDevice

rele = OutputDevice(20)

s = None
while s != "s":
    s = input("Pulsa 1 para encender, 0 para apagar, s para salir: ").strip().lower()

    if s == "1":
        rele.on()
        print("Relé encendido")

    elif s == "0":
        rele.off()
        print("Relé apagado")


print("Bye!")
# El relé se apaga y desconecta al salir
# si se dejó encendido
