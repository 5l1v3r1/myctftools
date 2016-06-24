#!/bin/bash
#
netstat -an|grep LISTEN|grep -v :: | awk '$1=="tcp" || $1=="tcp4" {print $4}' > open_ports.txt
cat open_ports.txt
#
head_line=$(head -n 1 open_ports.txt)
last_line=$(tail -n 1 open_ports.txt)
#
cat open_ports.txt | grep 0.0.0.0 | while read line
do
    one_port=$(echo $line|awk -F : '{print $2}')

    if [ $head_line == $line ]; then
        ports="$one_port"
    else
        ports="$ports,$one_port"
    fi
    if [ $last_line == $line ]; then
        echo "open_ports: $ports"
        echo "You can get service type by: sudo nmap -sV -T4 -p$ports <ip>"
    fi
done
#
rm -f open_ports.txt
