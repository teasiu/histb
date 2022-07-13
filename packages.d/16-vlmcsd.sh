# install vlmcsd

chmod a+x ${ROOTFS}/usr/bin/vlmcsd
chmod 644 ${ROOTFS}/etc/systemd/system/vlmcsd.service
ln -sf ${ROOTFS}/etc/systemd/system/vlmcsd.service ${ROOTFS}/etc/systemd/system/multi-user.target.wants/vlmcsd.service
