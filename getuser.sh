#!/bin/bash

#get used user by shell
echo 'user list:'
echo '----------------'
cat '/etc/passwd' | egrep '/bin/bash|bin/sh'
cat '/etc/passwd' | egrep '/bin/bash|bin/sh' | awk -F : '{print $1}' > user.txt
echo 'save user file to user.txt'

if [ -r '/etc/shadow' ]; then
    echo -e '\nempty password:'
    echo '----------------'
    cat '/etc/shadow' | awk -F : '$2=="" {print $1}'
    echo -e '\npassword hash:'
    echo '----------------'
    cat '/etc/shadow' | awk -F : '$2!="" && $2!="*" && $2!="!!" {print $1,$2}'
    cat '/etc/shadow' | awk -F : '$2!="" && $2!="*" && $2!="!!" {print $2}' > hash.txt
    echo 'save hash file to hash.txt'
else
    echo -e '\nread shadow fail!'
fi
