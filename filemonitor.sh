#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage:./filemoniter.sh <wwwbase> [init]" 
    echo "      wwwbase:the www dir"
    echo "      init:remove all tmp file"
    exit
fi
#www base dir
wwwbase=$1
wwwbase_backup='/tmp/backup'
wwwbase_copy='/tmp/copy'
#recent minute:
newfiletimesep=-60
#check time,second
sleeptimesep=5
snapfile="/tmp/snapfile.txt"
newfile="/tmp/newfile.txt"
#
recovery_from_backup(){
    backupfile=$(echo $1|sed "s:$wwwbase:$wwwbase_backup:g")
    if ! cmp -s $1 $backupfile
    then
        #recovery file
        cp -f $backupfile $1
        echo -e "\033[31mmodified file:$1,recoveried!\033[m"
    fi
}
copy_modified_file(){
    backupfile=$(echo $1|sed "s:$wwwbase:$wwwbase_backup:g")
    if ! cmp -s $1 $backupfile
    then
        #file not same
        copyfile=$wwwbase_copy/$(echo $1|sed "s:\.:_:g"|sed "s:/:_:g")
        cp -f $1 $copyfile
    fi
}
delete_new_file(){
    rm -f $1
    if [ -f "$1" ]; then
        echo -e "\033[31mnew file:$1,delted fail!\033[m"
    else
        echo -e "new file:$1,deleted"
    fi   
}
check_modified_file(){
    for line2 in $(cat $newfile)
    do
        copy_modified_file $line2
        if [  -z $(egrep "^$line2$" $snapfile) ]; then
            delete_new_file $line2
        else
            recovery_from_backup $line2
        fi
    done
}
if [ $# -eq 2 ] && [ $2 == 'init' ]; then
    echo 'init...'
    rm -rf $wwwbase_backup
    rm -rf $wwwbase_copy
    rm -f $snapfile
    rm -f $newfile
fi
echo 'prepare...'
#get all current file to snapfile.txt
if [ ! -f "$snapfile" ]; then
    find $wwwbase -type f -print > $snapfile
fi
#make backup
if [ ! -d "$wwwbase_backup" ]; then
    mkdir -p $wwwbase_backup
    cp -R  $wwwbase/* $wwwbase_backup
fi
#prepare for copy new file
if [ ! -d "$wwwbase_copy" ]; then
    mkdir -p $wwwbase_copy
fi
echo 'run...'
#do check
while true
do
    find $wwwbase -type f -mmin $newfiletimesep -print > $newfile
    check_modified_file
    sleep $sleeptimesep
done
