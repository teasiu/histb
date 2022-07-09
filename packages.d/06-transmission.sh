# install transmission

cat << EOF | LC_ALL=C LANGUAGE=C LANG=C chroot ${ROOTFS}
apt-get install -y transmission-daemon
EOF

cd ${WORK_PATH}
mkdir -p ${ROOTFS}/usr/share/transmission/web ${ROOTFS}/etc/transmission-daemon
mv -f ${ROOTFS}/usr/share/transmission/web/index.html ${ROOTFS}/usr/share/transmission/web/index.original.html
tar -zxvf package_files/transmission/tr-web-control.tar.gz -C ${ROOTFS}/usr/share/transmission/web > /dev/null 2>&1

cp package_files/transmission/settings.json ${ROOTFS}/etc/transmission-daemon/settings.json
cat << EOF | LC_ALL=C LANGUAGE=C LANG=C chroot ${ROOTFS}
chown -R debian-transmission:debian-transmission /etc/transmission-daemon
EOF
