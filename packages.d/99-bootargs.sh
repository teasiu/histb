# choose mv100 or mv200
echo "
1. mv200
2. mv300
"
while :; do
read -p "你想要定制哪个版本？ " CHOOSE
case $CHOOSE in
    1)
        bootargs="mv200"
    break
    ;;
    2)
        bootargs="mv300"
    break
    ;;
esac
done
cd ${WORK_PATH}
echo "hi3798$bootargs" > target
cp -a pre_files/bootargs/bootargs4-${bootargs}-64.bin ${ROOTFS}/usr/bin/bootargs4.bin
cp -a pre_files/bootargs/boot4.sh ${ROOTFS}/usr/bin/recoverbackup
chmod 777 ${ROOTFS}/usr/bin/recoverbackup
echo "hi3798$bootargs" > ${ROOTFS}/etc/hostname
