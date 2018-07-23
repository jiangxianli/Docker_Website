#!bin/bash

PROJECT_DIR=$DOCKER_PROJECT_DIR
# PID地址
PID_FILE=$PROJECT_DIR\\docker.pid

# 停止容器运行
if [  -f $PID_FILE ];then
    docker container stop $(cat $PID_FILE ) && rm -rf $PID_FILE
fi