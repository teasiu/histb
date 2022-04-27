#!/bin/bash

WORK_PATH=$(cd $(dirname $0) && pwd )
ROOTFS="${WORK_PATH}/rootfs"
WWW_PATH="${ROOTFS}/var/www/html"
DOWNLOAD_PATH="${WORK_PATH}/downloads"
PKG_SCRIPT_PATH="${WORK_PATH}/packages.d"

source ${WORK_PATH}/utils.sh

mkdir -p ${WWW_PATH}
mkdir -p ${DOWNLOAD_PATH}

wget_cmd() {
	wget --no-check-certificate --timeout 15 -4 --tries=5 -P ${DOWNLOAD_PATH} $* || exit 1
}

install_all_package() {
	packages=`find ${PKG_SCRIPT_PATH}|grep "\.sh$"|sort`
	for i in $packages ;do
		package=$i
		echo "executing ${package}"
		source ${package}
		echo "${package} executed"
	done
}

install_package() {
	for arg in $* ;do
		pkg_name=$arg
		script_file=${PKG_SCRIPT_PATH}/${pkg_name}.sh

		if [ -f ${script_file} ]; then
			echo "installing ${pkg_name}"
			source ${script_file}
			echo "${pkg_name} installed"
		else
			_exit 1 "Failed to find package script: ${script_file} ."
		fi
	done
}

apt_update() {
	cat << EOF | chroot ${ROOTFS}
apt-get update
apt-get upgrade -y
EOF
}

apt_clear() {
	cat << EOF | chroot ${ROOTFS}
	apt-get autoremove --purge -y
	apt-get autoclean -y
	apt-get clean -y
EOF
}

main() {
	# apt_update
	# install_package nginx typecho h5ai transmission ttyd frpc aria2 v2ray teslamate \
	# 	docker samba web2 webdav gitweb nfs-server vsftpd others bootargs
	install_all_package
	# apt_clear
}

main
