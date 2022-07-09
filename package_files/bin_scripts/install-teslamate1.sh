# 用于Ubuntu环境安装teslamate

# 1. 安装docker和docker-compose
apt-get update

if [ ! -f "/usr/bin/docker" ]; then
  echo "docker is to be intalled!"
  apt install -y docker.io lsof
else
  echo "docker is already intalled!"
fi

if [ ! -f "/usr/local/bin/docker-compose" ]; then
  echo "docker-compose is to be intalled!"
  apt install -y docker-compose
else
  echo "docker-compose is already intalled!"
fi

# 2. 创建目录
if [ ! -d "/opt/teslamate" ]; then
  mkdir /opt/teslamate
else
  rm -fr /opt/teslamate
  mkdir /opt/teslamate
fi
cd /opt/teslamate

# 3. 下载配置文件并安装启动
cp -a /usr/share/bak/gitweb/docker-compose.yml /opt/teslamate
docker-compose up -d

# 4.check and finish！
lsof -i:4000
lsof -i:3000

