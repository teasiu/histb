# install h5ai

install_package 00-nginx.sh
pkg_name="h5ai"

cd ${WORK_PATH}

mkdir -p ${WWW_PATH}/files
mkdir -p ${ROOTFS}/home/ubuntu/files
chmod -R 777 ${ROOTFS}/home/ubuntu/files
ln -sf /home/ubuntu/files ${WWW_PATH}/files/home

# cp pre_files/h5ai/{_h5ai.footer.md,_h5ai.header.html} ${WWW_PATH}/files
# cp pre_files/h5ai/_h5ai.footer2.md ${ROOTFS}/home/ubuntu/files/_h5ai.footer.md
tar -zxvf pre_files/h5ai/h5ai.tar.gz -C ${WWW_PATH}/files > /dev/null 2>&1

