# alist

cat >${ROOTFS}/etc/systemd/system/alist.service <<EOF
[Unit]
Description=Alist service
Wants=network.target
After=network.target network.service

[Service]
Type=simple
WorkingDirectory=$INSTALL_PATH
ExecStart=$INSTALL_PATH/alist
KillMode=process

[Install]
WantedBy=multi-user.target
EOF
chmod 644 ${ROOTFS}/etc/systemd/system/alist.service

cat << EOF | chroot ${ROOTFS}
systemctl enable alist
EOF
