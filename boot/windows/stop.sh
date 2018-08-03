#!/usr/bin/bash
source ./common.sh

if [[ "$1" == "show_tip" && -f $PID_FILE ]]; then
    read -n 1 -p "已有容器正在运行，是否关闭重启？[y/N]:" OK
    echo -e "\n"
    if [ "$OK" != "y" ]; then
        exit 2
    fi
fi

# 停止容器运行
if [  -f $PID_FILE ];then
    CONTAINER_ID=`cat $PID_FILE`
    echo  "正在关闭容器$CONTAINER_ID..."
    docker container stop $CONTAINER_ID && rm -rf $PID_FILE
    echo  "已关闭容器$CONTAINER_ID..."
fi