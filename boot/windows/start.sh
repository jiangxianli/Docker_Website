#!/usr/bin/bash

# 获取父级目录路径
PROJECT_DIR=$DOCKER_PROJECT_DIR
# PID地址
PID_FILE=$PROJECT_DIR\\docker.pid

# 提权后台运行容器
docker run  --rm --privileged -dit \
    -p 80:80 \
    -v $PROJECT_DIR\\nginx\\nginx.conf:/etc/nginx/nginx.conf \
    -v $PROJECT_DIR\\nginx\\conf.d:/etc/nginx/conf.d \
    -v $PROJECT_DIR\\php\\5.6\\fpm\\www.conf:/etc/opt/remi/php56/php-fpm.d/www.conf \
    -v $PROJECT_DIR\\php\\7.0\\fpm\\www.conf:/etc/opt/remi/php70/php-fpm.d/www.conf \
    -v $PROJECT_DIR\\php\\7.2\\fpm\\www.conf:/etc/opt/remi/php72/php-fpm.d/www.conf \
    -v $PROJECT_DIR\\profile\\profile:/etc/profile \
    -v $PROJECT_DIR\\host\\host:/etc/hosts \
    -v $PROJECT_DIR\\www:/www/wwwroot \
    website docker_boot > $PID_FILE

# 初始化
winpty docker exec -it $(cat $PID_FILE ) sh -c "sh /boot.sh"
# 进入容器终端
winpty docker exec -it $(cat $PID_FILE ) bash                                                            