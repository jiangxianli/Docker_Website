#!/bin/bash
source ./common.sh

if [  -f $PID_FILE ];then
    echo "正在进入容器终端...."
    docker exec -it $(cat $PID_FILE ) /bin/bash
else
    read -n 1 -p "没有容器正在运行，是否启动容器？[y/N]:" OK
    echo -e "\n"
    if [ "$OK" != "y" ]; then
        exit 0
    fi
    sh start.sh
fi