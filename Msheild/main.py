#!/usr/bin/env python
#-*- coding:utf-8 -*0

import sys
import os

def copy(source,dest):
    a=open(source,'r')
    code=a.read()
    a.close()
    b=open(dest,'w')
    b.write(code)
    b.close()

def fixbug(dirname,level):
    if level=="easy":
        f=os.path.abspath('.')+os.sep+"safe_easy.php"
        copy(f,dirname+os.sep+"safe_easy.php")
    elif level=="normal":
        f=os.path.abspath('.')+os.sep+"safe_normal.php"
        #copy(f,dirname+os.sep+"safe_normal.php")
    else:
        print "do not have this level"
        os._exit(0)
    module="safe_"+level+".php"
    for root, dirs, files in os.walk(dirname):
        for f in files:
            try:
                f.index(".php")
            except:
                pass
            else:
                if f==module:
                    pass
                else:
                    php=os.path.join(root,f)
                    insertphp(php,level)
def insertphp(fname,level):
    f=os.path.abspath('.')+os.sep+"safe_"+level+".php"
    #module="safe_"+level+".php"
    dest=open(fname,'r')
    code=dest.read()
    head="<?php require_once(\"%s\");?>\n" % f
    code=head+code
    dest.close()
    dest=open(fname,'w+')
    dest.write(code)
    dest.close()
    print "%s add the safe module with level %s" %(fname,level)

def main():
    if len(sys.argv)==1 or len(sys.argv)==2:
        print "usage:main.py [your web document] [safe level](easy|normal|hard)"
    else:
        fixbug(sys.argv[1],sys.argv[2])

if __name__ == '__main__':
    main()
    