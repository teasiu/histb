# others
cd ${WORK_PATH}
cp -a pre_files/client-mode ${ROOTFS}/home/ubuntu/
chmod 777 -R pre_files/sbin
cp -a pre_files/sbin/* ${ROOTFS}/sbin
cp -a pre_files/profile.d/* ${ROOTFS}/etc/profile.d
chmod 777 -R ${ROOTFS}/etc/profile.d
sed -i "s/ports.ubuntu.com/mirrors.aliyun.com/g" ${ROOTFS}/etc/apt/sources.list
echo "$(date +%Y%m%d)" > ${ROOTFS}/etc/nasversion
