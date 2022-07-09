#!/bin/bash
source utils.sh

ARCH="armhf"
if [ -n "$1" ]; then
    case "$1" in
        -64)
            export ARCH="arm64"
            ;;
        *)
            exit 1 "usage: 1-init-img.sh [-64]"
            ;;
    esac
fi

RELEASE="20.04.4"
IMG_FILE="ubuntu-base-${RELEASE}-base-${ARCH}.tar.gz"
IMG_URL="https://cdimage.ubuntu.com/ubuntu-base/releases/${RELEASE}/release"

mkdir -p downloads && cd downloads

if [ "$(get_sha256 -c ${IMG_URL}/SHA256SUMS ${IMG_FILE})" != "$(get_sha256 -l ${IMG_FILE})" ]
then
	wget --no-check-certificate ${IMG_URL}/${IMG_FILE} || _exit 1 "Failed to download ${IMG_FILE} ..."
fi

cd -
if [ ! -d rootfs ]
then
	mkdir -p rootfs
elif [ "$(ls -A rootfs)" ]
then
	rm -rf rootfs/*
fi
tar -zxvf downloads/${IMG_FILE} -C rootfs
echo -e "$RELEASE\n$ARCH" > target_arch
