#!/bin/bash

case $1 in 
-a)
	case $2 in
	best | all | http)
		tracker_type=$2
	;;
	*)
		echo "Usage: $0 -a <best | all | http>"
		exit 1
	;;
	esac
;;
*)
	while true
	do
		clear
		echo -e "Aria2 BT Tracker 自动更新脚本

	1. 完整列表 (推荐)
		\e[33m最完整的 Tracker 列表, 最有效的 BT 提速方式!\e[0m
	2. 精选列表
		\e[33m精选的 Tracker 列表, 仅提供可用的地址以减少网络资源消耗!\e[0m
	3. HTTP(S) 列表
		\e[33m仅提供 HTTP(S) 类型的 Tracker, 有限的 BT 提速方式!\e[0m

	\e[34mPowered by https://trackerslist.com\e[0m
	"
		read -p "请选择一个心仪的列表:" type
		case "$type" in
		1) tracker_type=all && break ;;
		2) tracker_type=best && break ;;
		3) tracker_type=http && break ;;
		esac
	done
;;
esac

config_file=/usr/local/aria2/aria2.conf
tracker_tmpfile=/tmp/aria2-tracker
default_tracker_url=(
	https://trackerslist.com/${tracker_type}_aria2.txt
	https://cdn.staticaly.com/gh/XIU2/TrackersListCollection/master/${tracker_type}_aria2.txt
	https://fastly.jsdelivr.net/gh/XIU2/TrackersListCollection/${tracker_type}_aria2.txt
)
downloader_cmd="$(command -v wget) --quiet --no-check-certificate -4 --tries 1 --timeout 10 -O"

downloader() {
	local i ; for i in $@
	do
		${downloader_cmd} $tracker_tmpfile $i
		if [[ $? == 0 && -e $tracker_tmpfile ]]
		then
			echo "Downloaded Tracker list from $i"
			return 0
		else
			echo "Failed to download Tracker list from $i"
		fi
	done
	echo "Unable to download Tracker list from any url, pls check network connection and try again later ..."
	exit 1
}

rm -f $tracker_tmpfile
downloader ${default_tracker_url[@]}

if [[ $(systemctl is-active aria2c 2> /dev/null) == active ]]
then
	systemctl stop aria2c 2> /dev/null
fi

if [[ ! -f $config_file ]]
then
	echo "无法获取 Aria2c 配置文件: $config_file"
	exit 1
fi

echo "移除旧 BT Tracker-$tracker_type 列表 ..."
sed -i "/bt-tracker=/d" $config_file
echo "写入新 BT Tracker-$tracker_type 列表 ..."
echo -e "\nbt-tracker=$(cat $tracker_tmpfile)" >> $config_file

if [[ $(systemctl is-enabled aria2c 2> /dev/null) == enabled ]]
then
	echo "重启 Aria2 服务 ..."
	systemctl restart aria2c 2> /dev/null
fi

exit
