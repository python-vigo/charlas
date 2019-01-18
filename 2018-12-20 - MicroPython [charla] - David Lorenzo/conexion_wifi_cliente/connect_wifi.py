import network
from utime import sleep

def connect():
    # sta_if es la interfaz de red como cliente
    sta_if = network.WLAN(network.STA_IF)

    # Solo se conecta si la red está desconectada
    # Esto facilita poder llamar la funcion ocasionalmente desde fuera,
    # si queremos reconectarnos 
    if not sta_if.isconnected():
        print('connecting to network...')
        # Activar interfaz de red
        sta_if.active(True)
        # Leer SSID y password de Wifi desde los ficheros txt
        with open("WIFI_SSID.txt", "r") as f:
            ssid = f.read().strip()
        with open("WIFI_PASSWORD.txt", "r") as f:
            password = f.read().strip()
        # Conexión con la red Wifi
        sta_if.connect(ssid, password)
        # Opcionalmente, esperamos hasta que la red se conecte
        while not sta_if.isconnected():
            sleep(0.1)

    # Imprimir las IPs que obtuvo la placa por DHCP
    # Formato: tupla (ip, netmask, gateway, dns)
    print('network config:', sta_if.ifconfig())

    # Opcionalmente, deshabilitamos el punto de acceso Wifi creado por Micropython
    network.WLAN(network.AP_IF).active(False)

