# vsftpd

cat << EOF | LC_ALL=C LANGUAGE=C LANG=C chroot ${ROOTFS}
apt-get install -y vsftpd
EOF

# cd ${WORK_PATH}
# cp -a pre_files/vsftpd.conf ${ROOTFS}/etc/

# limit log size
sed -ri -e '/^\s+size\s+.*/d' /etc/logrotate.d/vsftpd
sed -ri -e 's/^(\s+)(rotate\s+).*/\1\21\n\1size 1M/g' /etc/logrotate.d/vsftpd
