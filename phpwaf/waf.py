#!/usr/bin/env python
#-*- coding: utf-8 -*-
import os
import sys

waf_path = os.path.abspath('.')+os.sep+"waf.php"
print waf_path

def scandir(startdir,op) :
    os.chdir(startdir)
    for obj in os.listdir(os.curdir) :
        path = os.getcwd() + os.sep + obj
        if os.path.isfile(path) and '.php' in obj:
            if op == "install":
                modifyip(path,'<?php','<?php\nrequire_once(\'%s\');'%waf_path) #强行加一句代码
            else:
                modifyip(path,'require_once(\'%s\');'%waf_path,'') #去掉waf的包含
        if os.path.isdir(obj) :
            scandir(obj,op)
            os.chdir(os.pardir)

def modifyip(tfile,sstr,rstr):
    try:
        lines=open(tfile,'r').readlines()
        flen=len(lines)-1
        for i in range(flen):
            if sstr in lines[i]:
                lines[i]=lines[i].replace(sstr,rstr)
        open(tfile,'w').writelines(lines)

    except Exception,e:
        print e

def install_waf():
    scandir(sys.argv[1],"install")

def uninstall_waf():
    scandir(sys.argv[1],"uninstall")

def main():      
    if len(sys.argv) <2:
        print "Usage:%s <wwwbase> [uninstall]" %sys.argv[0]
        exit()
    if len(sys.argv) == 2
        install_waf()
    else if len(sys.argv) ==3  and sys.argv[2] == 'uninstall':
        uninstall_waf();

if __name__ == '__main__':
    main()
    