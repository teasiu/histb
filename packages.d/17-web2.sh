# install web2

# cd ${WORK_PATH}
# cp -a pre_files/wiki/nginx_any168 ${ROOTFS}/etc/nginx/sites-available/nginx_any168
# cp -a pre_files/wiki/{favicon.ico,zhinan.html,ftp.html} ${WWW_PATH}/
# cp -a pre_files/wiki/{css,img,js,fonts,images} ${WWW_PATH}/


cat << EOF | chroot ${ROOTFS}
ln -s /etc/nginx/sites-available/nginx_any168 /etc/nginx/sites-enabled/nginx_any168
EOF
