# install nginx with php

cat << EOF | LC_ALL=C LANGUAGE=C LANG=C chroot ${ROOTFS}
apt-get install -y nginx php-fpm php-sqlite3 libnginx-mod-http-dav-ext
EOF
cd ${WORK_PATH}
mkdir -p ${ROOTFS}/etc/nginx/sites-available
mkdir -p ${ROOTFS}/etc/nginx/locations.d

mv ${WWW_PATH}/index.nginx-debian.html ${WWW_PATH}/index3.html

# disable logs
sed -i 's/access_log .*;/access_log off;/g' ${ROOTFS}/etc/nginx/nginx.conf
sed -i 's/error_log .*;/error_log \/dev\/null;/g' ${ROOTFS}/etc/nginx/nginx.conf

# change body_size
sed -ri 's/^(\s+)(types_hash_max_size\s+.*$)/\1\2\n\1client_max_body_size 500m;/g' ${ROOTFS}/etc/nginx/nginx.conf
sed -i 's/^post_max_size.*/post_max_size = 500M/g' ${ROOTFS}/etc/php/7.4/fpm/php.ini
sed -i 's/^upload_max_filesize.*/upload_max_filesize = 500M/g' ${ROOTFS}/etc/php/7.4/fpm/php.ini
sed -i 's/^post_max_size.*/post_max_size = 500M/g' ${ROOTFS}/etc/php/7.4/cli/php.ini
sed -i 's/^upload_max_filesize.*/upload_max_filesize = 500M/g' ${ROOTFS}/etc/php/7.4/cli/php.ini

# html-php
sed -i "404c security.limit_extensions = .php .php3 .php4 .php5 .php7 .html" ${ROOTFS}/etc/php/7.4/fpm/pool.d/www.conf

# limit log size
sed -ri -e '/^\s+size\s+.*/d' ${ROOTFS}/etc/logrotate.d/php7.4-fpm
sed -ri -e 's/^(\s+)(rotate\s+).*/\1\21\n\1size 1M/g' ${ROOTFS}/etc/logrotate.d/php7.4-fpm
