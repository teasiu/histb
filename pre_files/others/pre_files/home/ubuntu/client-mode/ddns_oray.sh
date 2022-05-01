#!/bin/bash

user=
passwd=
hostname=

oldIP=`cat ddns_cur_ip3.dat`
curExIP=`curl http://members.3322.org/dyndns/getip | tee ddns_cur_ip3.dat`

if [ "$curExIP" != "$oldIP" ];then
    echo "Refresh IP from $oldIP to: $curExIP"
    orayHttpAdd="http://$user:$passwd@ddns.oray.com/ph/update?hostname=$hostname"
    curl $orayHttpAdd
else
    echo "No change on external IP - $curExIP"
fi

