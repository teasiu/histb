# vsftpd

cat << EOF | LC_ALL=C LANGUAGE=C LANG=C chroot ${ROOTFS}
apt-get install -y vsftpd
EOF

cd ${WORK_PATH}
cp -a pre_files/vsftpd.conf ${ROOTFS}/etc/
