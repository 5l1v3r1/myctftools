#!/bin/bash

netstat -an|grep LISTEN|awk '$1=="tcp" || $1=="tcp4" {print $4}'
