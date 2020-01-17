import paho.mqtt.client as mqtt

client = mqtt.Client()


def on_connect(*args):
    print("Conectado a broker!")
    client.subscribe("topic1")
    client.subscribe("topic2")
    client.subscribe("pc/cmd")
    client.publish("pc/stat", "Estoy Online!")


def on_disconnect(*args):
    print("Desconectado!")


def on_message(client, userdata, msg):
    print("Rx MQTT Message")
    print("\tTopic:", msg.topic)
    print("\tPayload:", msg.payload.decode())


client.on_connect = on_connect
client.on_message = on_message
client.on_disconnect = on_disconnect

client.will_set("pc/stat", "Me he morido", retain=True)

if __name__ == '__main__':
    client.connect("127.0.0.1", 1883)

    try:
        client.loop_forever()
    except (KeyboardInterrupt, InterruptedError):
        # client.disconnect()
        pass
