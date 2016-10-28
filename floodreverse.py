#!/usr/bin/env python
#-*- coding:utf-8 -*-

import threading
import socket
import random
import hashlib
import time
import sys

APP_RUNNING = True
TIME_DELAY = 0.5

def get_flag():
    random_num = random.randint(1,100000000)
    random_flag = hashlib.new("md5", str(random_num)).hexdigest()

    return 'flag{%s}' % random_flag

def flood(ip,ports):
    while APP_RUNNING:
        for port in ports:
            if APP_RUNNING == False:
                return
            try:
                sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)  
                sock.connect((ip, port))  
                sock.send(get_flag())  
                sock.close()
            except:
                pass
        time.sleep(TIME_DELAY)

def main():
    hosts = ({'host':'172.16.5.1','ports':(6061,6062)},
            {'host':'172.16.5.149','ports':(6061,)},
        )
    socket.setdefaulttimeout(5)
    print 'start run...'
    flood_threads = []
    for host in hosts:
        ip = host['host']
        ports = host['ports']
        flood_threads.append(threading.Thread(target=flood,args=(ip,ports)))
    for t in flood_threads:
        t.setDaemon(True)
        t.start()
    while True:
        try:
            time.sleep(1)
        except KeyboardInterrupt:
            APP_RUNNING = False
            print 'exit...'
            sys.exit()


if __name__ == '__main__':
    main()