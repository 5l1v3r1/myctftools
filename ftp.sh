#!/bin/sh

if [ ! $# -eq 1 ]; then
    echo 'Usage:ftp.sh <host>'
    exit 
fi

HOST=$1
PORT=21
USER="user1"
PASSWD="qwe123"
LOCAL_FILE="flag.txt"
REMOTE_FILE="/var/www/html/test/f.txt"

ftp -n $HOST $PORT <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
put $LOCAL_FILE $REMOTE_FILE
quit
END_SCRIPT
exit 0