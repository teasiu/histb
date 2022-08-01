# install frpc

# frpc
mkdir -p ${ROOTFS}/etc/frp
chmod +x ${ROOTFS}/usr/bin/frpc
chmod 644 ${ROOTFS}/etc/systemd/system/frpc.service


cat << EOF | chroot ${ROOTFS}
systemctl enable frpc
EOF

cat << EOF | chroot ${ROOTFS}
mkdir -p /etc/nginx/sites-enabled
ln -s /etc/nginx/sites-available/nginx_any168 /etc/nginx/sites-enabled/nginx_any168
EOF
