#!/bin/bash

if [ -f /usr/bin/frpc ];then 
subdomainid=$(awk 'NR==1' /etc/first_init 2> /dev/null)
sed -i "s/xxxxx/$subdomainid/g" /var/www/html/index2.html
sed -i "s/xxxxx/$subdomainid/g" /var/www/html/zhinan.html
fi
