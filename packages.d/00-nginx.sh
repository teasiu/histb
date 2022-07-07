# install nginx with php

cat << EOF | LC_ALL=C LANGUAGE=C LANG=C chroot ${ROOTFS}
apt-get install -y nginx php-fpm php-sqlite3 libnginx-mod-http-dav-ext
EOF
cd ${WORK_PATH}
mkdir -p ${ROOTFS}/etc/nginx/sites-available

# disable logs
sed -i 's/access_log .*;/access_log off;/g' ${ROOTFS}/etc/nginx/nginx.conf
sed -i 's/error_log .*;/error_log \/dev\/null;/g' ${ROOTFS}/etc/nginx/nginx.conf

# phpinfo
cat <<EOT > ${WWW_PATH}/info.php
<?php
phpinfo();
?>
EOT

# html-php
sed -i "404c security.limit_extensions = .php .php3 .php4 .php5 .php7 .html" ${ROOTFS}/etc/php/7.4/fpm/pool.d/www.conf

# limit log size
sed -ri -e '/^\s+size\s+.*/d' /etc/logrotate.d/php7.4-fpm
sed -ri -e 's/^(\s+)(rotate\s+).*/\1\21\n\1size 1M/g' /etc/logrotate.d/php7.4-fpm