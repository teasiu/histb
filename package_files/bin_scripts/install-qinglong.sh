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
check_dockerimage(){
  docker inspect qinglong -f '{{.Name}}' > /dev/null
  if [ $? -eq 0 ] ;then
    echo "青龙镜像已存在，请不要重复安装"
  else
    install_dockerimage
    echo 123 > /etc/qlinstalled
  fi
}
install_dockerimage(){
docker pull whyour/qinglong:latest
docker run -dit \
  -v $PWD/ql:/ql/data \
  -v /dev:/dev \
  -p 5700:5700 \
  --name qinglong \
  --hostname qinglong \
  --restart unless-stopped \
  whyour/qinglong:latest
}
local_ip=$(ifconfig eth0 | grep '\<inet\>'| grep -v '127.0.0.1' | awk '{ print $2}' | awk 'NR==1')
if [ -x "$(command -v docker)" ]; then
  echo "docker已安装." >&2
  check_dockerimage
else
  apt update && apt install docker.io -y
  check_dockerimage
fi
sleep 1
echo "青龙面板已经安装，首次安装请1分钟后浏览器打开 http://$local_ip:5700 进入设置"
