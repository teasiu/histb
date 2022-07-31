# install tailscale

install_dir="/opt/tailscale"

chmod a+x ${ROOTFS}/$install_dir/tailscale*
chmod a+x ${ROOTFS}/usr/bin/install-tailscale
ln -sf $install_dir/tailscale ${ROOTFS}/usr/bin/tailscale
ln -sf $install_dir/tailscaled ${ROOTFS}/usr/bin/tailscaled
