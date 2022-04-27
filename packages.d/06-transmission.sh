# install transmission

cat << EOF | LC_ALL=C LANGUAGE=C LANG=C chroot ${ROOTFS}
apt-get install -y transmission-daemon
EOF

cd ${WORK_PATH}
mkdir -p ${ROOTFS}/usr/share/transmission/web ${ROOTFS}/etc/transmission-daemon
mv -f ${ROOTFS}/usr/share/transmission/web/index.html ${ROOTFS}/usr/share/transmission/web/index.original.html
tar -zxvf pre_files/transmission/tr-web-control.tar.gz -C ${ROOTFS}/usr/share/transmission/web > /dev/null 2>&1
cp -a pre_files/transmission/tr-settings.json ${ROOTFS}/etc/transmission-daemon/settings.json

