# install vlmcsd

chmod a+x ${ROOTFS}/usr/bin/vlmcsd
chmod 644 ${ROOTFS}/etc/systemd/system/vlmcsd.service
ln -sf /etc/systemd/system/vlmcsd.service ${ROOTFS}/etc/systemd/system/multi-user.target.wants/vlmcsd.service
