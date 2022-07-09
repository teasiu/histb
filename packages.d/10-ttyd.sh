# install ttyd

case "$ARCH" in
    armhf)
        export ttyd_file="ttyd.armhf"
        ;;
    arm64)
        export ttyd_file="ttyd.aarch64"
        ;;
esac

ttyd_url="https://git.histb.com/tsl0922/ttyd/releases/download/1.6.3/${ttyd_file}"

if [ ! -f ${DOWNLOAD_PATH}/${ttyd_file} ]; then
    wget_cmd ${ttyd_url}
fi

cd ${WORK_PATH}
chmod 644 ${ROOTFS}/etc/systemd/system/ttyd.service
cp -a ${DOWNLOAD_PATH}/${ttyd_file} ${ROOTFS}/usr/bin/ttyd
chmod +x ${ROOTFS}/usr/bin/ttyd

cat << EOF | chroot ${ROOTFS}
systemctl enable ttyd
EOF
