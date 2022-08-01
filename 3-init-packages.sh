#!/bin/bash
source utils.sh

usage() {
    cat <<-EOF
Usage: usage: 3-init-packages.sh [<package name> ...]
EOF
    _exit $1
}

ARCH=$(awk 'NR==2' target_arch 2> /dev/null)
WORK_PATH=$(cd $(dirname $0) && pwd )
ROOTFS="${WORK_PATH}/rootfs"
WWW_PATH="${ROOTFS}/var/www/html"
DOWNLOAD_PATH="${WORK_PATH}/downloads"
PKG_SCRIPT_PATH="${WORK_PATH}/packages.d"

mkdir -p ${WWW_PATH}
mkdir -p ${DOWNLOAD_PATH}

wget_cmd() {
	wget --no-check-certificate --timeout 15 -4 --tries=5 -P ${DOWNLOAD_PATH} $* || exit 1
}

copy_files() {
	pkg_name=$1
	copy_dir=$2
	if [ -d ${WORK_PATH}/package_files/${pkg_name}/${copy_dir}/common ]; then
		cp -a ${WORK_PATH}/package_files/${pkg_name}/${copy_dir}/common/* ${ROOTFS}
	fi
	if [ -d ${WORK_PATH}/package_files/${pkg_name}/${copy_dir}/${ARCH} ]; then
		cp -a ${WORK_PATH}/package_files/${pkg_name}/${copy_dir}/${ARCH}/* ${ROOTFS}
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
                copy_files $pkg_name pre_files

                source ${script_file}

                # copy posted files
                copy_files $pkg_name post_files

                echo "${pkg_name} executed"
                export ${pkg_name}_installed="true"
            fi
        else
            _exit 1 "Failed to find package script: ${script_file}"
        fi
    done
}

install_all_package() {
    if [ "$*" = "" ]; then
        packages=`find ${PKG_SCRIPT_PATH}|grep "\.sh$"|sort`
	else
        packages=$*
	fi
	
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
EOF
	rm -f ${ROOTFS}/root/.bash_history
}

main() {
	apt_update
	install_all_package $*
	apt_clear
}

main "$@"
