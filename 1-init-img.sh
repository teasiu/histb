#!/bin/bash
source utils.sh

ARCH="armhf"

usage() {
    cat <<-EOF
Usage: usage: 1-init-img.sh [-mv100|mv200|mv300] [-64]
EOF
    _exit $1
}

while [ $# -gt 0 ]; do
    if [ -z "$1" ]; then
        usage 0
    else
        case "$1" in
            --help | -h)
                usage 0
                ;;
            -mv100)
                model="mv100"
                shift
                ;;
            -mv200)
                model="mv200"
                shift
                ;;
            -mv300)
                model="mv300"
                shift
                ;;
            -64)
                ARCH="arm64"
                shift
                ;;
            *)
                usage 1
                ;;
        esac
    fi
done

if [ -z "$model" ]; then
    if [ "$ARCH" = "armhf" ]; then
        echo "
        1. mv100
        2. mv200
        3. mv300
        "
        while :; do
        read -p "你想要定制哪个版本？ " CHOOSE
        case $CHOOSE in
            1)
                model="mv100"
            break
            ;;
            2)
                model="mv200"
            break
            ;;
            3)
                model="mv300"
            break
            ;;
        esac
        done
    else
        echo "
        1. mv200
        2. mv300
        "
        while :; do
        read -p "你想要定制哪个版本？ " CHOOSE
        case $CHOOSE in
            1)
                model="mv200"
            break
            ;;
            2)
                model="mv300"
            break
            ;;
        esac
        done
    fi
fi

if [ "$model" = "mv100" ] && [ "$ARCH" = "arm64" ]; then
    _exit 1 "mv100 haven't 64bit version, plese execute again"
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
echo "$model" > target
