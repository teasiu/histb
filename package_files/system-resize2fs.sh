#!/bin/bash
# execute resize2fs when first boot

cat > rootfs/etc/systemd/system/resize2fs.service <<EOF
[Unit]
Description=resize2fs local filesystem
Before=local-fs-pre.target
DefaultDependencies=no

[Service]
Type=oneshot
TimeoutSec=infinity
ExecStart=/usr/sbin/local-resize2fs.sh
RemainAfterExit=true

[Install]
RequiredBy=local-fs-pre.target
EOF

cat > rootfs/usr/sbin/local-resize2fs.sh <<EOF
#!/bin/bash
if [ ! -f /etc/first_init ]; then
    resize2fs /dev/mmcblk0p9 2>&1 > /dev/null
fi
exit 0
EOF

chmod 644 rootfs/etc/systemd/system/resize2fs.service
chmod a+x rootfs/usr/sbin/local-resize2fs.sh
mkdir -p rootfs/etc/systemd/system/local-fs-pre.target.wants
ln -sf /etc/systemd/system/resize2fs.service rootfs/etc/systemd/system/local-fs-pre.target.wants/resize2fs.service

