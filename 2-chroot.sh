#!/bin/bash

echo "nameserver 223.5.5.5" >> rootfs/etc/resolv.conf
sed -i "s/ports.ubuntu.com/repo.huaweicloud.com/g" rootfs/etc/apt/sources.list
echo "127.0.0.1 localhost" > rootfs/etc/hosts
cp -a package_files/system-init.sh rootfs/etc/init.d
mkdir -p rootfs/etc/first_init.d
chmod +x rootfs/etc/init.d/system-init.sh

cat << EOF | LC_ALL=C LANGUAGE=C LANG=C chroot rootfs
mknod /dev/console c 5 1
mknod /dev/ttyAMA0 c 204 64
mknod /dev/ttyAMA1 c 204 65
mknod /dev/ttyS000 c 204 64
mknod /dev/null    c 1   3
mknod /dev/urandom   c 1   9
mknod /dev/zero    c 1   5
mknod /dev/random    c 1   8
mknod /dev/tty    c 5   0
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y jq ntfs-3g smartmontools usbutils dnsutils network-manager \
locales wget curl vim iputils-ping bash-completion \
ssh net-tools sudo \
cron ethtool zip ifupdown htop rsyslog dialog resolvconf
sed -i -e 's/#PasswordAuthentication/PasswordAuthentication/g' /etc/ssh/sshd_config
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
dpkg-reconfigure -f noninteractive tzdata
echo "en_US.UTF-8 UTF-8
zh_CN.UTF-8 UTF-8
zh_CN.GB2312 GB2312
zh_CN.GBK GBK" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo 'LC_CTYPE="en_US.UTF-8"
LC_ALL="en_US.UTF-8"
LANG="en_US.UTF-8"
' > /etc/default/locale
update-rc.d system-init.sh defaults 90
useradd -s '/bin/bash' -m -G adm,sudo ubuntu
gpasswd -a ubuntu sudo
echo -e "1234\n1234\n" | passwd ubuntu
echo -e "1234\n1234\n" | passwd root
echo "www-data ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
rm -f /etc/systemd/system/multi-user.target.wants/networkd-dispatcher.service
echo "debug.exception-trace = 0" > /etc/sysctl.d/00-debug-exception-trace.conf
visudo -c
sed -ri -e '/^\s+size\s+.*/d' /etc/logrotate.d/*
sed -ri -e 's/^(\s+)(rotate\s+).*/\1\21\n\1size 1M/g' /etc/logrotate.d/*
echo "net.core.rmem_max=4195328" > /etc/sysctl.d/10-udp-mem.conf
echo "net.core.wmem_max=4195328" >> /etc/sysctl.d/10-udp-mem.conf
echo "net.core.wmem_default=4195328" >> /etc/sysctl.d/10-udp-mem.conf
echo "net.core.rmem_default=4195328" >> /etc/sysctl.d/10-udp-mem.conf
echo "net.ipv4.udp_mem=4195328 4195328 4195328" >> /etc/sysctl.d/10-udp-mem.conf
echo "net.ipv4.udp_rmem_min=4195328" >> /etc/sysctl.d/10-udp-mem.conf
echo "net.ipv4.udp_wmem_min=4195328" >> /etc/sysctl.d/10-udp-mem.conf
apt-get autoremove --purge -y
apt-get autoclean -y
apt-get clean -y
EOF

cat <<EOT >> rootfs/etc/fstab
tmpfs /tmp tmpfs defaults,nosuid 0 0
/dev/mmcblk0p9 / ext4 defaults,noatime,errors=remount-ro 0 1
EOT

mkdir -p rootfs/etc/network/interfaces.d
touch -f rootfs/etc/network/interfaces.d/eth0
cat <<EOT >> rootfs/etc/network/interfaces.d/eth0
auto eth0
iface eth0 inet dhcp
EOT

# resize2fs
source package_files/system-resize2fs.sh
