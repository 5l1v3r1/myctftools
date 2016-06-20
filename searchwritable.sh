#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage:./searchwritable.sh <wwwbase>" 
    exit
fi
wwwbase=$1
find $wwwbase -type d -perm /o+w > writable.txt
cat writable.txt
