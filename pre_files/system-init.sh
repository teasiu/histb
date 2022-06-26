#!/bin/bash

### BEGIN INIT INFO
# Provides:          slitaz.cn
# Required-Start:
# Required-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: self define auto start
# Description:       self define auto start
### END INIT INFO

if [ ! -f /etc/first_init ]
then
	resize2fs /dev/mmcblk0p6 &
	sudomainid=`date +%s%N | md5sum | cut -c 1-5`
	sshport=`shuf -i 10000-65535 -n1`
	sed -i "s/xxxxx/$sudomainid/g" /etc/frp/frpc.ini
	sed -i "s/ppppp/$sshport/g" /etc/frp/frpc.ini
	sed -i "s/xxxxx/$sudomainid/g" /var/www/html/zhinan.html
	sed -i "s/xxxxx/$sudomainid/g" /var/www/html/index2.html
	dmesg | grep "CPU: hi" | awk -F ':[ ]' '/CPU/{printf ($2)}' > /etc/regname
fi
if [ ! -f /etc/first_init ]
then
	echo "resize2fs /dev/mmcblk0p6" > /etc/first_init
fi
if [ ! -f /swapfile ]
then
{
	dd if=/dev/zero of=/swapfile bs=1M count=512
	chmod 600 /swapfile
	mkswap /swapfile
	swapon /swapfile
} &
fi
grep -q '/swapfile' /etc/fstab || echo "/swapfile swap swap defaults,nofail 0 0" >> /etc/fstab

echo 42 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio42/direction

echo "/sbin/automount" > /sys/kernel/uevent_helper
/sbin/automount -a &
/sbin/net_status &
/sbin/vlmcsd &

