#!/bin/bash
#get database username and password

if [ $# -eq 0 ]; then
    echo "Usage:./searchcms.sh <wwwbase>" 
    exit
fi

#config var
basedir=$1
filefind="*config*|*cfg*"
userpass="user|pass"
#
for wwwdir in `ls $basedir`; do
    currentdir="$basedir/$wwwdir"
    output_html="./$wwwdir.html"
    if [ -d $currentdir ]; then
        find $currentdir -type f -iname "${filefind}" | xargs egrep -i "${userpass}" | awk -F : '{printf "<a href=%s target=blank>%s</a>%s<br>\n",$1,$1,$2}' > $output_html
    fi
done
