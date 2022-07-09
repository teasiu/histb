# choose mv100 or mv200

if [ "$ARCH" = "armhf" ]; then
    echo "
    1. mv100
    2. mv200
    3. mv300
    "
    while :; do
    read -p "你想要定制哪个版本？ " CHOOSE
    case $CHOOSE in
        1)
            bootargs="mv100"
        break
        ;;
        2)
            bootargs="mv200"
        break
        ;;
        3)
            bootargs="mv300"
        break
        ;;
    esac
    done
else
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
fi

cd ${WORK_PATH}
echo "hi3798$bootargs" > target
cp -a package_files/bootargs/bootargs4-$bootargs.bin ${ROOTFS}/usr/bin/bootargs4.bin
cp -a package_files/bootargs/recoverbackup_${ARCH} ${ROOTFS}/usr/bin/recoverbackup
chmod 777 ${ROOTFS}/usr/bin/recoverbackup
echo "hi3798$bootargs" > ${ROOTFS}/etc/hostname
