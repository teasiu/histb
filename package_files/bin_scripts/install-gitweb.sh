#!/bin/bash
# Only support Debian 10

if [ `whoami` != "root" ]; then
    echo "sudo or root is required!"
    exit 1
fi

if [ ! -f "/etc/debian_version" ]; then
    echo "Boss, do you want to try debian?"
    exit 1
fi
check_gitweb(){
  type gitweb > /dev/null 2>&1
  if [ $? -eq 0 ] ;then
    echo "gitweb软件已存在，请不要重复安装"
    exit 1
  else
    install_gitweb
  fi
}
install_gitweb(){
  apt update && apt install git gitweb nginx fcgiwrap -y
  systemctl stop nginx
  cp -a /usr/share/bak/gitweb/nginx_gitweb /etc/nginx/sites-available/gitweb
  ln -sf /etc/nginx/sites-{available,enabled}/gitweb
  cp -a /usr/share/bak/gitweb/gitweb.cgi /usr/share/gitweb
  cp -a /usr/share/bak/gitweb/indextext.html /usr/share/gitweb
  cp -a /usr/share/bak/gitweb/gitweb.conf /etc
  systemctl start nginx
}
check_gitweb

