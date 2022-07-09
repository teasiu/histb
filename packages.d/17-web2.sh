# install web2

cat << EOF | chroot ${ROOTFS}
ln -s /etc/nginx/sites-available/nginx_any168 /etc/nginx/sites-enabled/nginx_any168
EOF
