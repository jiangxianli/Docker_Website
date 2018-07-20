#!/bin/bash

# 获取当前目录路径
CUR_DIR=$(cd `dirname $0`; pwd)
# 获取父级目录路径
PROJECT_DIR=$(cd `dirname $CUR_DIR`/../; pwd)

# 编译
docker build -t website $PROJECT_DIR