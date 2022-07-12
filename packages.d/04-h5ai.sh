# install h5ai

install_package 00-nginx.sh
pkg_name="h5ai"

cd ${WORK_PATH}

mkdir -p ${WWW_PATH}/files
mkdir -p ${ROOTFS}/home/ubuntu/files
chmod -R 777 ${ROOTFS}/home/ubuntu/files
ln -sf /home/ubuntu/files ${WWW_PATH}/files/home

tar -zxvf package_files/h5ai/h5ai.tar.gz -C ${WWW_PATH}/files > /dev/null 2>&1
