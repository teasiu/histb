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

copy_pre_files() {
	pkg_name=$1
	if [ -d ${WORK_PATH}/pre_files/${pkg_name}/pre_files ]; then
		cp -a ${WORK_PATH}/pre_files/${pkg_name}/pre_files/* ${ROOTFS}
	fi
}

copy_post_files() {
	pkg_name=$1
	if [ -d ${WORK_PATH}/pre_files/${pkg_name}/post_files ]; then
		cp -a ${WORK_PATH}/pre_files/${pkg_name}/post_files/* ${ROOTFS}
	fi
}

# 参数使用脚本名称带 .sh 后缀
install_package() {
    for arg in $* ;do
        script_file=${PKG_SCRIPT_PATH}/${arg}
        pkg_name=$(echo $arg|sed -r "s/[0-9]+-(.*)\.sh/\1/g")

        eval pkg_installed='${'"${pkg_name}_installed"'}'
        if [ -f ${script_file} ]; then
            if [ ! ${pkg_installed} ]; then
                # copy pre files
                copy_pre_files $pkg_name

                source ${script_file}

                # copy posted files
                copy_post_files $pkg_name

                echo "${pkg_name} executed"
                export ${pkg_name}_installed="true"
            fi
        else
            _exit 1 "Failed to find package script: ${script_file}"
        fi
    done
}

install_all_package() {
	packages=`find ${PKG_SCRIPT_PATH}|grep "\.sh$"|sort`
	for i in $packages ;do
		pkg_script=`basename $i`
		install_package $pkg_script
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
	rm /root/.bash_history 2> /dev/null
EOF
}

main() {
	apt_update
	install_all_package
	apt_clear
}

main
