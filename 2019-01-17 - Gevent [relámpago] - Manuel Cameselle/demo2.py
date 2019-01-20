#!/usr/bin/python
# -*- coding: utf-8 -*-

import gevent.monkey
gevent.monkey.patch_socket()

import gevent
import urllib2
import json
from time import time

def fetch(pid):
    response = urllib2.urlopen('http://now.httpbin.org')
    result = response.read()
    json_result = json.loads(result)
    datetime = json_result['now']['epoch']

    print('Process %s: %s' % (pid, datetime))

def synchronous():
    for i in range(1,10):
        fetch(i)

def asynchronous():
    threads = []
    for i in range(1,10):
        threads.append(gevent.spawn(fetch, i))
    gevent.joinall(threads)

print('Synchronous:')
print(time())
synchronous()
print(time())

print('-')

print('Asynchronous:')
print(time())
asynchronous()
print(time())
