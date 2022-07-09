#!/bin/bash

sudomainid=`date +%s%N | md5sum | cut -c 1-5`
sshport=`shuf -i 10000-65535 -n1`
sed -i "s/xxxxx/$sudomainid/g" /etc/frp/frpc.ini
sed -i "s/ppppp/$sshport/g" /etc/frp/frpc.ini
