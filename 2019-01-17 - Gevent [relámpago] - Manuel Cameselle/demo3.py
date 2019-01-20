#!/usr/bin/python
# -*- coding: utf-8 -*-


# ¡¡¡¡¡ EJEMPLO NO FUNCIONAL solo para propósito didáctico !!!!!


import socket
from gevent import monkey; monkey.patch_all()
from gevent import socket
from gevent import queue
import gevent
import pymysql


conn_rx_pool = conn_pool(NCONN)
conn_tx = pymysql.Connection()


global hilos_rx_dict
hilos_rx_dict = dict()


hilos = (gevent.spawn(transmitir_tramas),
             gevent.spawn(recibir_tramas),
             )
gevent.wait(hilos)


class conn_pool():
    def __init__(self, nconn):
        self.pool = queue.Queue()
        
        for i in range(nconn):
            conn = pymysql.Connection()
            self.pool.put(conn)
    
    def get_conn(self):
        return self.pool.get() 

    def ret_conn(self, conn):
        self.pool.put(conn)


def transmitir_tramas():
    while run: # Bucle infinito del que saldremos cuando alguien ponga la variable global run a False
        try:
            num = tx_tramas(conn_tx)
            if num == 0:
                gevent.sleep(0.25)


def recibir_tramas():
                data, address = udp.recvfrom()
                gevent.spawn(paraleliza_trama, data, address[0], address[1])


def paraleliza_trama(data, iptxt, puerto):
    datos = decod(data)
    nserie = datos['nserie']
    
    # comprobamos si ya hay al menos una trama de este nserie procesándose
    g = None
    if nserie in hilos_rx_dict:
        g = hilos_rx_dict[nserie]
    
    # anotamos que somos el último (así si llega otra trama más de este nserie, se pondrá a la cola "detrás" de ésta)
    hilos_rx_dict[nserie] = gevent.getcurrent()
    
    if g is not None:
        # hay una trama de este mismo nserie todavía en proceso => esperaremos nuestro turno
        # nos quedamos aquí "dormidos" hasta que finalize el procesado de la trama anterior de este nserie
        g.join()
    
    try:
        # cogemos una conexión del pool
        # (si no hubiese ninguna libre nos quedaríamos aquí esperando ya que el pool ha sido construido con gevent.queue)
        db = conn_rx_pool.get_conn()
        
        procesa_trama(db, iptxt, puerto, datos)
    
    except:
        pass
        
    finally:
        if db:
            # devolvemos la conexión al pool
            conn_rx_pool.ret_conn(db)
        
        # comprobamos si ha llegado alguna trama más de este nserie mientras procesábamos ésta
        if hilos_rx_dict[nserie] == gevent.getcurrent():
            # no ya llegado ninguna trama más, sino hubiera cambiado de valor
            # por tanto somos los "ultimos" y debemos "limpiar" el diccionario para que las siguientes no esperen
            hilos_rx_dict[nserie] = None
