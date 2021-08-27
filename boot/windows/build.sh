#!/usr/bin/bash

source ./common.sh

# 构建镜像
###
# --rm 如果已存在website镜像，则删除website镜像
# --no-cache=true build时，禁止缓存
# -t 设定镜像名字 website
###
docker build --rm --no-cache=false -t website $PROJECT_DIR
