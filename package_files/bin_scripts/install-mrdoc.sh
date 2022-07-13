#!/bin/bash
if [ `whoami` != "root" ]; then
    echo "sudo提权或使用root用户权限执行"
    exit 1
fi

if [ ! -f "/etc/debian_version" ]; then
    echo "老板，请使用ubuntu系统"
    exit 1
fi
mkdir -p /opt/note
wget https://dl.ecoo.top:2096/update/soft_init/mrdoc.tar.gz
tar -zxvf mrdoc.tar.gz -C /opt/note
apt update
apt install uwsgi-plugin-python3 python3.8-venv -y
cp /opt/note/mrdoc_deploy/mrdoc.service /etc/systemd/system/
systemctl enable mrdoc
cp /opt/note/mrdoc_deploy/mrdoc_nginx.conf /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/mrdoc_nginx.conf /etc/nginx/sites-enabled/mrdoc_nginx.conf
nginx -s reload
systemctl start mrdoc
rm mrdoc.tar.gz
echo "觅思文档管理系统已安装，请打开 IP:10888 端口访问"

