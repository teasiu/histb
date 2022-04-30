# install docker

cd ${WORK_PATH}
cp -a pre_files/install-portainer.sh ${ROOTFS}/usr/bin
cp -a pre_files/wiki/install-portainer.php ${WWW_PATH}
cp -a pre_files/install-qinglong.sh ${ROOTFS}/usr/bin
cp -a pre_files/install-jellyfin.sh ${ROOTFS}/usr/bin
cp -a pre_files/wiki/install-qinglong.php ${WWW_PATH}
chmod +x ${ROOTFS}/usr/bin/install-portainer.sh
chmod +x ${ROOTFS}/usr/bin/install-qinglong.sh
chmod +x ${ROOTFS}/usr/bin/install-jellyfin.sh

