# vsftpd

cat << EOF | LC_ALL=C LANGUAGE=C LANG=C chroot ${ROOTFS}
apt-get install -y vsftpd
EOF

# limit log size
sed -ri -e '/^\s+size\s+.*/d' ${ROOTFS}/etc/logrotate.d/vsftpd
sed -ri -e 's/^(\s+)(rotate\s+).*/\1\21\n\1size 1M/g' ${ROOTFS}/etc/logrotate.d/vsftpd
