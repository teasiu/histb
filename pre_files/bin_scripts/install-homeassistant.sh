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

while :; do
read -p "请输入 config 映射目录的绝对路径: " config_path
if [[ ! -d $config_path ]] || [[ "$config_path" == "" ]]; then
	echo "路径" $config_path "不存在，请重新输入"
else
	break
fi
done

check_dockerimage(){
  docker inspect homeassistant -f '{{.Name}}' > /dev/null
  if [ $? -eq 0 ] ;then
    echo "homeassistant镜像已存在，请不要重复安装"
  else
    install_dockerimage
  fi
}

install_dockerimage(){
docker pull linuxserver/homeassistant:latest
docker run -dit \
  -v ${config_path}:/config \
  -p 8123:8123 \
  --name homeassistant \
  --hostname homeassistant \
  --restart unless-stopped \
  linuxserver/homeassistant:latest
}

local_ip=$(ifconfig eth0 | grep '\<inet\>'| grep -v '127.0.0.1' | awk '{ print $2}' | awk 'NR==1')
if [ -x "$(command -v docker)" ]; then
  echo "docker已安装，请不要重复安装." >&2
  check_dockerimage
else
  apt update && apt install docker.io -y
  check_dockerimage
fi
sleep 1
echo "homeassistant已经安装，首次安装请1分钟后浏览器打开http://$local_ip:8123进入设置"
