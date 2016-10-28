#!/bin/bash
ps -ef | grep httpd | awk '{print $2,$3}' | while read line
do
  #echo $line
  PIDS=($line)
  if [ ${PIDS[1]} -eq 1 ]; then
    echo ${PIDS[0]} "fpid is 1"
  else
    echo "killing" ${PIDS[0]}
    kill -9 ${PIDS[0]}
  fi
done