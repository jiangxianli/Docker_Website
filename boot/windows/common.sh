#!/usr/bin/bash

# 获取当前目录路径
CUR_DIR=$(cd `dirname $0`; pwd)
# 获取父级目录路径
PROJECT_DIR=$(echo "${CUR_DIR:1:1}:${CUR_DIR:2}" | sed 's/\//\\\\/g')\\..\\..
# PID地址
PID_FILE=$CUR_DIR/docker.pid

