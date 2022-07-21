# install webdav

install_package 00-nginx.sh

mkdir -p ${ROOTFS}/home/ubuntu/webdav
echo "/home/ubuntu/webdav/" > ${ROOTFS}/home/ubuntu/webdav/这是一个测试文档.txt

cat << EOF | chroot ${ROOTFS}
ln -s /etc/nginx/sites-available/nginx_webdav /etc/nginx/sites-enabled/nginx_webdav
EOF
