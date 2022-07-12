# install vlmcsd

chmod a+x ${ROOTFS}/usr/bin/vlmcsd
ln -sf ${ROOTFS}/etc/systemd/system/vlmcsd.service ${ROOTFS}/etc/systemd/system/multi-user.target.wants/vlmcsd.service
