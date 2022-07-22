# choose mv100 or mv200
bootargs=$(awk 'NR==1' ${WORK_PATH}/target 2> /dev/null)
if [ "$bootargs" = "" ]; then
    _exit 1 "target not found"
fi

cd ${WORK_PATH}
[ "$ARCH" = "arm64" ] && is64="-64"
cp -a package_files/bootargs/bootargs4-${bootargs}${is64}.bin ${ROOTFS}/usr/bin/bootargs4.bin
cp -a package_files/bootargs/emmc_bootargs-${bootargs}${is64}.txt ${ROOTFS}/etc/bootargs_input.txt
chmod 777 ${ROOTFS}/etc/bootargs_input.txt
cp -a package_files/bootargs/recoverbackup_${ARCH} ${ROOTFS}/usr/bin/recoverbackup
chmod 777 ${ROOTFS}/usr/bin/recoverbackup
echo "hi3798$bootargs" > ${ROOTFS}/etc/hostname
