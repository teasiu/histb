# install nginx with php

if [ ! ${nginx_installed} ]; then
    cat << EOF | LC_ALL=C LANGUAGE=C LANG=C chroot ${ROOTFS}
apt-get install -y nginx php-fpm php-sqlite3 libnginx-mod-http-dav-ext
EOF
    cd ${WORK_PATH}
    mkdir -p ${WWW_PATH}/files ${ROOTFS}/etc/nginx/sites-available
    mkdir -p ${ROOTFS}/home/ubuntu/files
    ln -sf /home/ubuntu/files ${WWW_PATH}/files/home

    # phpinfo
    cat <<EOT > ${WWW_PATH}/info.php
<?php
phpinfo();
?>
EOT

    # html-php
    sed -i "404c security.limit_extensions = .php .php3 .php4 .php5 .php7 .html" ${ROOTFS}/etc/php/7.4/fpm/pool.d/www.conf

    nginx_installed="true"
fi

