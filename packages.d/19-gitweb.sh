# install webdav

# gitweb
cd ${WORK_PATH}
cp -a pre_files/install-gitweb.sh ${ROOTFS}/usr/bin
chmod +x ${ROOTFS}/usr/bin/install-gitweb.sh
mkdir -p ${ROOTFS}/usr/share/bak
cp -a pre_files/wiki/gitweb ${ROOTFS}/usr/share/bak
