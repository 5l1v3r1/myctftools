#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage:nmap.sh <network/mask>"
    exit
fi

netscan=$1
discoveryfile="Discovery.gnmap"

nmap -sn -T4 -oG $discoveryfile $netscan
grep "Status: Up" Discovery.gnmap | cut -f 2 -d ' ' > iplist.txt

rm -f $discoveryfile
cat iplist.txt



