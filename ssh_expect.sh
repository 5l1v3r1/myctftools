#!/usr/bin/expect

#argv0:host
#argv1:user
#argv2:password


set timeout 5
set host [lindex $argv 0]
set user [lindex $argv 1]
set password [lindex $argv 2]

spawn ssh "$user@$host"
expect {
    "(yes/no)?" {
        send "yes\r"
        expect "password:" {send "$password\r"}
    }
    "password:" {
         send "$password\r"
    }
}
send "id\r"
send "whoami\r"
expect eof
exit

