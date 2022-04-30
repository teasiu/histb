#!/bin/bash

user=
passwd=
hostname=

oldIP=`cat ddns_cur_ip2.dat`
curExIP=`curl http://members.3322.org/dyndns/getip | tee ddns_cur_ip2.dat`

if [ "$curExIP" != "$oldIP" ];then
    echo "Refresh IP from $oldIP to: $curExIP"
    noipcom="http://$user:$password@dynupdate.no-ip.com/nic/update?hostname=$hostaname&myip=$curExIP"
    curl $noipcom
else
    echo "No change on external IP - $curExIP"
fi

