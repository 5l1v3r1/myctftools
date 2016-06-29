#!/bin/sh

if [ ! $# -eq 1 ]; then
    echo 'Usage:ftp.sh <host>'
    exit 
fi

HOST=$1
PORT=21
USER="user1"
PASSWD="qwe123"
LOCAL_FILE="u.php"
REMOTE_FILE="/var/www/html/test/.u.php"

ftp -n $HOST $PORT <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
put $LOCAL_FILE $REMOTE_FILE
put c.php /var/www/html/test/.c.php
quit
END_SCRIPT
exit 0