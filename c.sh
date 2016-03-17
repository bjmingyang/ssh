#!/bin/sh
# \
exec expect -- "$0" ${1+"$@"}
exp_version -exit 5.0
#if {$argc!=2} {
 #   send_user "usage: remote-exec command password\n"
  #  send_user "Eg. remote-exec \"ssh user@host ls\\; echo done\" password\n"
   # send_user "or: remote-exec \"scp /local-file user@host:/remote-file\" password\n"
    #send_user "or: remote-exec \"scp user@host:/remote-file local-file\" password\n"
    #send_user "or: remote-exec \"rsync --rsh=ssh /local-file user@host:/remote-file\" password\n"
    #send_user "Caution: command should be quoted.\n"
    #exit
#}
set cmd [lindex $argv 0]
#set password daodao
set password daodao.com
#set cmd "ssh 10.10.11.17"
#set cmd "ssh 10.10.11.17 'racadm sshpkauth -i 2 -k 2 -t \\\\\"ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEArXjgcZPuB2uN6j1/X/qnyJdIw2zfPln6j1a5p1hx6YFAfPhywtkMncbZ7xmQL4GSK+TvOrTpWzSUWFfG0j7Oz4bfYTjbBhywgZ8UASDAifLycX+4eBBKVOVvlSZBlMRk0Ah2+hTBJlMxtowiM0/dibiqqeW8Qb1Z4ehgl6j0BGJtEj9wfNwwdHZZPElP5Ix2grzZVkJOPwo9RZiFHcLGNL97H1vPJd99KQGkFdGZoYslfbUFFEyhijxit4+Zo0FIhZ5SM2mUW64zOrhvwVXWkDS5srqeX41xOidrZJDQXLYzVAmHOt8YFunY4qmtj7l4Hjyp6kdotQU+JuUSON9t3Q== root@adm01t.daodao.com\\\\\" '"
eval spawn $cmd
#set timeout 30
while {1} {
    expect -re "Are you sure you want to continue connecting (yes/no)?" {
            # First connect, no public key in ~/.ssh/known_hosts
            send "yes\r"
        } -re "assword:" {
            # Already has public key in ~/.ssh/known_hosts
            send "$password\r"
        } -re "Permission denied, please try again." {
            # Password not correct
            exit
        } -re "kB/s|MB/s" {
            # User equivalence already established, no password is necessary
            set timeout -1
        } -re "file list ..." {
            # rsync started
            set timeout -1
        } -re "successful" {
            exit
        } -re "admin1" {
           send "racadm sshpkauth -i 2 -k 4 -t \"ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEArXjgcZPuB2uN6j1/X/qnyJdIw2zfPln6j1a5p1hx6YFAfPhywtkMncbZ7xmQL4GSK+TvOrTpWzSUWFfG0j7Oz4bfYTjbBhywgZ8UASDAifLycX+4eBBKVOVvlSZBlMRk0Ah2+hTBJlMxtowiM0/dibiqqeW8Qb1Z4ehgl6j0BGJtEj9wfNwwdHZZPElP5Ix2grzZVkJOPwo9RZiFHcLGNL97H1vPJd99KQGkFdGZoYslfbUFFEyhijxit4+Zo0FIhZ5SM2mUW64zOrhvwVXWkDS5srqeX41xOidrZJDQXLYzVAmHOt8YFunY4qmtj7l4Hjyp6kdotQU+JuUSON9t3Q== root@adm01t.daodao.com\"\r"
           set timeout -1
        } -re "bind: Address already in use" {
            # For local or remote port forwarding
            set timeout -1
        } -re "Is a directory|No such file or directory" {
            exit
        } -re "Connection refused" {
            exit
        } timeout {
            exit
        } eof {
            exit
        }
}
