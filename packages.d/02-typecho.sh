# install typecho

typecho_file="1.1-17.10.30-release.tar.gz"
typecho_url="http://typecho.org/downloads/${typecho_file}"

if [ ! -f ${DOWNLOAD_PATH}/${typecho_file} ]; then
    wget_cmd ${typecho_url}
fi

install_package 00-nginx

# blog & html
tar -zxvf ${DOWNLOAD_PATH}/${typecho_file} -C ${WWW_PATH} > /dev/null 2>&1
cd ${WWW_PATH}
mv build blog
chmod 777 -R blog
mv index.nginx-debian.html index3.html
cd ${WORK_PATH}
cp pre_files/wiki/nginx_default ${ROOTFS}/etc/nginx/sites-available/default
cp pre_files/wiki/index.html ${WWW_PATH}
cp pre_files/wiki/index2.html ${WWW_PATH}
cp pre_files/wiki/{kms.html,teasiu-wx.jpg,ec6108v9.jpg} ${WWW_PATH}/

