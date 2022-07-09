#!/bin/bash

sudomainid=`date +%s%N | md5sum | cut -c 1-5`
sed -i "s/xxxxx/$sudomainid/g" /var/www/html/index2.html

