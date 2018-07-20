#!/bin/bash

# 获取当前目录路径
CUR_DIR=$(cd `dirname $0`; pwd)
# 获取父级目录路径
PROJECT_DIR=$(cd `dirname $CUR_DIR`/../; pwd)
# PID地址
PID_FILE=$PROJECT_DIR/docker.pid

# 提权后台运行容器
docker run  --rm --privileged -dit  \
    -p 80:80 \
    -v $PROJECT_DIR/nginx/nginx.conf:/etc/nginx/nginx.conf \
    -v $PROJECT_DIR/nginx/conf.d:/etc/nginx/conf.d \
    -v $PROJECT_DIR/php/5.6/fpm/www.conf:/etc/opt/remi/php56/php-fpm.d/www.conf \
    -v $PROJECT_DIR/php/7.0/fpm/www.conf:/etc/opt/remi/php70/php-fpm.d/www.conf \
    -v $PROJECT_DIR/php/7.2/fpm/www.conf:/etc/opt/remi/php72/php-fpm.d/www.conf \
    -v $PROJECT_DIR/boot/boot.sh:/usr/bin/docker_boot \
    -v $PROJECT_DIR/profile/profile:/etc/profile \
    -v $PROJECT_DIR/host/host:/etc/hosts \
    -v $PROJECT_DIR/www:/www/wwwroot \
    website > $PID_FILE

# 进入容器终端
docker exec -it $(cat $PID_FILE )  /bin/bash