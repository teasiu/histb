# install typecho

install_package 00-nginx.sh
pkg_name="typecho"

typecho_file="1.1-17.10.30-release.tar.gz"
typecho_url="https://git.histb.com/teasiu/histb/releases/download/20220716/${typecho_file}"

if [ ! -f ${DOWNLOAD_PATH}/${typecho_file} ]; then
    wget_cmd ${typecho_url}
fi

# blog & html
tar -zxvf ${DOWNLOAD_PATH}/${typecho_file} -C ${WWW_PATH} > /dev/null 2>&1
cd ${WWW_PATH}
mv build blog
chmod 777 -R blog
cd ${WORK_PATH}
