#!/usr/bin/python
# -*- coding: utf-8 -*-

import gevent
import random

def task(pid):
    gevent.sleep(random.randint(0,2)*0.001)
    print('Task %s done' % pid)

print('Asynchronous:')
threads = [gevent.spawn(task, i) for i in xrange(10)]
gevent.joinall(threads)
