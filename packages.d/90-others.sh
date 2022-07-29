# others
cd ${WORK_PATH}

chmod 777 -R package_files/others/sbin
cp -a package_files/others/sbin/${ARCH}/* ${ROOTFS}/sbin

chmod 777 -R ${ROOTFS}/etc/profile.d
chmod 755 ${ROOTFS}/usr/bin/nasinfo
sed -i "s/ports.ubuntu.com/repo.huaweicloud.com/g" ${ROOTFS}/etc/apt/sources.list
echo "$(date +%Y%m%d)" > ${ROOTFS}/etc/nasversion
