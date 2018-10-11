#!/bin/bash
source ./common.sh

# 检测先关闭容器
source ./stop.sh show_tip

# 提权后台运行容器
echo "正在启动容器...."
docker run  --rm --privileged -dit \
    -p 80:80 \
    -v $PROJECT_DIR/nginx/nginx.conf:/etc/nginx/nginx.conf \
    -v $PROJECT_DIR/nginx/laravel-index.conf:/etc/nginx/laravel-index.conf \
    -v $PROJECT_DIR/nginx/php7.0.conf:/etc/nginx/php7.0.conf \
    -v $PROJECT_DIR/nginx/php5.6.conf:/etc/nginx/php5.6.conf \
    -v $PROJECT_DIR/nginx/php7.2.conf:/etc/nginx/php7.2.conf \
    -v $PROJECT_DIR/nginx/conf.d:/etc/nginx/conf.d \
    -v $PROJECT_DIR/php/5.6/fpm/www.conf:/etc/opt/remi/php56/php-fpm.d/www.conf \
    -v $PROJECT_DIR/php/7.0/fpm/www.conf:/etc/opt/remi/php70/php-fpm.d/www.conf \
    -v $PROJECT_DIR/php/7.2/fpm/www.conf:/etc/opt/remi/php72/php-fpm.d/www.conf \
    -v $PROJECT_DIR/profile/profile:/etc/profile \
    -v $PROJECT_DIR/host/host:/etc/hosts \
    -v $PROJECT_DIR/www:/www/wwwroot \
    website | cut -c1-12 > $PID_FILE

# 初始化
docker exec -it $(cat $PID_FILE ) sh -c "sh /boot.sh"

# 进入容器终端
echo "正在进入容器终端...."
docker exec -it $(cat $PID_FILE ) /bin/bash