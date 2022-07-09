# install frpc

# frpc
mkdir -p ${ROOTFS}/etc/frp
chmod +x ${ROOTFS}/usr/bin/frpc
chmod 644 ${ROOTFS}/etc/systemd/system/frpc.service


cat << EOF | chroot ${ROOTFS}
systemctl enable frpc
EOF
