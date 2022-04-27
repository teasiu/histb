# install samba

cd ${WORK_PATH}
cp -a pre_files/install-samba.sh ${ROOTFS}/usr/bin
cp -a pre_files/wiki/install-samba.php ${WWW_PATH}
chmod +x ${ROOTFS}/usr/bin/install-samba.sh

