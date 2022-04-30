# install frpc

# frpc
mkdir -p ${ROOTFS}/etc/frp
# cp pre_files/frpc/frpc ${ROOTFS}/usr/bin
chmod +x ${ROOTFS}/usr/bin/frpc
# cp pre_files/frpc/frpc.ini ${ROOTFS}/etc/frp
# cp pre_files/frpc/frpc.service ${ROOTFS}/etc/systemd/system
chmod 644 ${ROOTFS}/etc/systemd/system/frpc.service


cat << EOF | chroot ${ROOTFS}
systemctl enable frpc
EOF
