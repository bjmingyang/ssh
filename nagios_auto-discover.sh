#!/bin/sh
nmap -v -sn 192.168.4.0/24|grep -v "\[host down\]"|grep -v "Host is up"|grep daodao.com|awk -F" " '{print $5,$6} ' > /home/mwang/daodao1
i=1
SUM=`sed -n '$=' /home/mwang/daodao1` #计算文件的总行数
while read line
do
    arr[$i]="$line"
    i=`expr $i + 1`
done < /home/mwang/daodao1
i=1
mv /usr/local/nagios/etc/hosts/other/hosts /usr/local/nagios/etc/hosts/other/hosts.`date +%G%j`
/usr/local/nagios/etc/hosts/other/hosts
for i in `seq $SUM` ;do
x=`echo "${arr[$i]}"|awk -F".daodao.com" '{print $1}'`
y=`echo "${arr[$i]}"|awk -F" " '{print $2}'|sed 's/(//g'|sed 's/)//g'`
cat >> /usr/local/nagios/etc/hosts/other/hosts << EOF
define host {
        host_name               $x
        alias                   $x
        address                 $y
        contact_groups          sagroup
        check_command           check-host-alive
        max_check_attempts      5
        notification_interval   10
        notification_period     24x7
        notification_options    d,u,r
}
EOF
#    echo "${arr[$i]}"
done
