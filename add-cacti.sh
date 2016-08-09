#!/bin/bash

#cacti批量加监控

#cli_path=/var/lib/cacti/cli/
cli_path=/var/www/cacti/cli/
#web list

#use host name add to cacti
#读取IP列表

#host_ips=`cat web`
host_ips=`echo web{19..23}t`
for host_ip in $host_ips
do
#添加cacti设备
php "$cli_path"add_device.php --description="$host_ip" --ip="$host_ip" --template=10 --version=2 --community="public"
#读取设备ID
host_ids=`php $cli_path/add_graphs.php --list-hosts | grep $host_ip | awk -F " " '{print $1}'`
#创建模板图像
php "$cli_path"add_graphs.php --host-id="$host_ids" --graph-type=cg --graph-template-id=35
php "$cli_path"add_graphs.php --host-id="$host_ids" --graph-type=cg --graph-template-id=36
php "$cli_path"add_graphs.php --host-id="$host_ids" --graph-type=cg --graph-template-id=109
php "$cli_path"add_graphs.php --host-id="$host_ids" --graph-type=cg --graph-template-id=37
php "$cli_path"add_graphs.php --host-id="$host_ids" --graph-type=cg --graph-template-id=42
php "$cli_path"add_graphs.php --host-id="$host_ids" --graph-type=cg --graph-template-id=39
php "$cli_path"add_graphs.php --host-id="$host_ids" --graph-type=cg --graph-template-id=40
php "$cli_path"add_graphs.php --host-id="$host_ids" --graph-type=cg --graph-template-id=41

#创建网卡数据图像
php "$cli_path"add_graphs.php --host-id="$host_ids" --graph-type=ds --graph-template-id=2 --snmp-query-id=1 --snmp-query-type-id=16 --snmp-field=ifDescr --snmp-value="eth0"
php "$cli_path"add_graphs.php --host-id="$host_ids" --graph-type=ds --graph-template-id=2 --snmp-query-id=1 --snmp-query-type-id=16 --snmp-field=ifDescr --snmp-value="eth1"
php "$cli_path"add_graphs.php --host-id="$host_ids" --graph-type=ds --graph-template-id=2 --snmp-query-id=1 --snmp-query-type-id=16 --snmp-field=ifDescr --snmp-value="bond0"
#创建分区数据图像
php "$cli_path"add_graphs.php --host-id="$host_ids" --graph-type=ds --graph-template-id=3 --snmp-query-id=8 --snmp-query-type-id=18 --snmp-field=hrStorageDescr --snmp-value="/"
php "$cli_path"add_graphs.php --host-id="$host_ids" --graph-type=ds --graph-template-id=3 --snmp-query-id=8 --snmp-query-type-id=18 --snmp-field=hrStorageDescr --snmp-value="/disk1"
php "$cli_path"add_graphs.php --host-id="$host_ids" --graph-type=ds --graph-template-id=3 --snmp-query-id=8 --snmp-query-type-id=18 --snmp-field=hrStorageDescr --snmp-value="/disk2"
php "$cli_path"add_graphs.php --host-id="$host_ids" --graph-type=ds --graph-template-id=3 --snmp-query-id=8 --snmp-query-type-id=18 --snmp-field=hrStorageDescr --snmp-value="/disk3"
#create memcache images
memcache_port=`echo 11211 11321 11611 11911`
for x in $memcache_port
do
 path_port="--input-fields=port=$x --force"
echo $x
php  "$cli_path"add_graphs.php  --host-id=$host_ids --graph-type=cg --graph-template-id=174 --graph-title="|host_description| - Memcached  - Cache Hits and Misses -- $x"  $path_port
php  "$cli_path"add_graphs.php  --host-id=$host_ids --graph-type=cg --graph-template-id=175 --graph-title="|host_description| - Memcached  - Current Connections -- $x" $path_port
php  "$cli_path"add_graphs.php  --host-id=$host_ids --graph-type=cg --graph-template-id=176 --graph-title="|host_description| - Memcached  - Items Cached -- $x" $path_port
php  "$cli_path"add_graphs.php  --host-id=$host_ids --graph-type=cg --graph-template-id=177 --graph-title="|host_description| - Memcached  - Network Traffic \(bits/sec\) -- $x" $path_port
php  "$cli_path"add_graphs.php  --host-id=$host_ids --graph-type=cg --graph-template-id=178 --graph-title="|host_description| - Memcached  - Memcached - Requests/sec \(get/set\) -- $x " $path_port
done
#
#
tree=2
web=16
#添加设备到相应的组
php "$cli_path"add_tree.php --host-id="$host_ids" --type=node --node-type=host --tree-id=$tree --parent-node=$web
done
