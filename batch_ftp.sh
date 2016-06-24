#!/bin/bash

cat iplist.txt | while read line
do
    ./ftp.sh $line
done