#!/bin/bash

subdomainid=`date +%s%N | md5sum | cut -c 1-5`
sshport=`shuf -i 10000-65535 -n1`
sed -i "s/xxxxx/$subdomainid/g" /etc/frp/frpc.ini
sed -i "s/ppppp/$sshport/g" /etc/frp/frpc.ini
if [ -f /var/www/html/zhinan.html ];then
sed -i "s/xxxxx/$subdomainid/g" /var/www/html/zhinan.html
sed -i "s/xxxxx/$subdomainid/g" /var/www/html/index2.html
fi
