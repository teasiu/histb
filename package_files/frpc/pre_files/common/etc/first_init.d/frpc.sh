#!/bin/bash

subdomainid=$(awk 'NR==1' /etc/first_init 2> /dev/null)
sshport=`shuf -i 10000-65535 -n1`
sed -i "s/xxxxx/$subdomainid/g" /etc/frp/frpc.ini
sed -i "s/ppppp/$sshport/g" /etc/frp/frpc.ini
