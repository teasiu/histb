# install aria2
install_package 00-nginx.sh

cat << EOF | LC_ALL=C LANGUAGE=C LANG=C chroot ${ROOTFS}
apt-get install -y aria2
EOF

aria2_file="AriaNg-1.2.3.zip"
aria2_url="https://git.histb.com/mayswind/AriaNg/releases/download/1.2.3/${aria2_file}"

if [ ! -f ${DOWNLOAD_PATH}/${aria2_file} ]; then
    wget_cmd ${aria2_url}
fi

cd ${WORK_PATH}
mkdir -p ${ROOTFS}/home/ubuntu/downloads ${WWW_PATH}/ariang ${ROOTFS}/usr/local/aria2
chmod -R 777 ${ROOTFS}/home/ubuntu/downloads
chown nobody:nogroup ${ROOTFS}/home/ubuntu/downloads
unzip -o -q ${DOWNLOAD_PATH}/${aria2_file} -d ${WWW_PATH}/ariang
touch ${ROOTFS}/usr/local/aria2/aria2.session
chmod 777 ${ROOTFS}/usr/local/aria2/aria2.session
chmod 755 ${ROOTFS}/usr/local/bin/update-tracker.sh
chmod 644 ${ROOTFS}/etc/systemd/system/aria2c.service

cat << EOF | chroot ${ROOTFS}
systemctl enable aria2c.service
EOF
