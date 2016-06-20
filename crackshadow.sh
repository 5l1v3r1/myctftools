#!/bin/bash

hashfile="hash.txt"
outputfile="pass.txt"
dicfile="dic/top1500.txt"
#crack shadow by hashcat
hashcat -m 1800 -a 0 -o $outputfile  $hashfile $dicfile
