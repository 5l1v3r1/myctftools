#!/usr/bin/env python
# -*- coding:utf-8 -*-
import re

http_flag_log = 'flagserver.log'
r_dt = re.compile(r'\[(.*)\]')
r_flag = re.compile(r'\?f=(.*?)\s')

def parse_log():
    with open(http_flag_log,'r') as f:
        while True:
            line = f.readline()
            if not line:
                break
            line = line.strip()
            host = line.split(' ')[0]
            dt = r_dt.findall(line)[0].split(' ')[1]
            ff = r_flag.findall(line)
            flag = ff[0] if ff else None
            if flag is not None:
                print '[+]%s %s::%s' %(dt,host,flag)

def main():
    parse_log()

if __name__ == '__main__':
    main()