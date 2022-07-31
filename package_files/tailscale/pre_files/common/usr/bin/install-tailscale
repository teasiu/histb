#!/bin/bash

HEADSCALE_SERVER="https://p2p.ecoo.top:9191"
key_file="/opt/tailscale/key"

if [ -f $key_file ]; then
    preauthkey=$(awk 'NR==1' $key_file 2> /dev/null)
fi

usage() {
    cat <<-EOF
Usage: usage: install-tailscale.sh [-key <preauthkey>] [-save] [-restore <backup file path>]
EOF
    exit 1
}

save_data() {
    timestamp=$(date +%s%N | md5sum |cut -c 1-6)
    pwd_path=$(pwd)
    cd /var/lib
    tar czf /home/ubuntu/files/tailscale-backup-${timestamp}.tar.gz tailscale
    cd $pwd_path
    chown www-data:www-data /home/ubuntu/files/tailscale-backup-${timestamp}.tar.gz
    exit
}

restore_data() {
    backup_file_path=$1
    systemctl stop tailscaled 2>&1 > /dev/null
    rm -rf /var/lib/tailscale
    tar xf $backup_file_path -C /var/lib
    systemctl start tailscaled 2>&1 > /dev/null
    exit
}

while [ $# -gt 0 ]; do
    if [ -z "$1" ]; then
        usage 0
    else
        case "$1" in
            --help | -h)
                usage 0
                ;;
            -key)
                preauthkey=$2
                shift 2
                ;;
            -save)
                save_data
                shift
                ;;
            -restore)
                restore_data $2
                shift 2
                ;;
            *)
                usage 1
                ;;
        esac
    fi
done

systemctl enable --now tailscaled 2>&1 > /dev/null

if [ -n "$preauthkey" ]; then
    ip_addr=$(ifconfig eth0|sed -n 2p|awk '{print $2}')
    local_net=$(echo ${ip_addr%.*}).0/24
    echo "loging..."
    login_cmd="/usr/bin/tailscale up --login-server=${HEADSCALE_SERVER} --authkey $preauthkey --advertise-routes=${local_net} --accept-routes=true --accept-dns=false --reset"
    `$login_cmd` &

    timeout_seconds=5
    while [ $timeout_seconds -gt 0 ]; do
        if [ "$(netstat -lntup |grep 41641)" != "" ]; then
            echo "loging successed."
            break
        fi
        sleep 1
    done

    if [ $timeout_seconds -eq 0 ]; then
        echo "loging failed."
        ps -aux | grep "$login_cmd" | grep -v "grep" | awk '{print $2}' | while read line; do
            kill -9 $line
        done
        exit 1
    fi
fi


