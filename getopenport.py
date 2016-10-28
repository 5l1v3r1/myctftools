#!/usr/bin/env python
#-*- coding:utf-8 -*-
import subprocess,socket,time

cmd = 'netstat -ant|grep tcp|grep LISTEN'
port_sep = ':'
def main():
    p = subprocess.Popen(cmd,shell=True,stdout=subprocess.PIPE)  
    lines = p.stdout.readlines()
    ports = []
    for line in lines:
        cols = [ ]
        for c in line.strip().split(' '):
            if len(c) >0:
                cols.append(c)
        if len(cols) > 3:
            ports.append(int(cols[3].split(port_sep)[-1]))
    ports_sorted = sorted(list(set((ports))))
    ports_str = ','.join([ str(x) for x in ports_sorted ])
    print 'open ports:%s' %ports_sorted
    print 'nmap -sV -T4 -p %s' %(ports_str)

if __name__ == '__main__':
    main()