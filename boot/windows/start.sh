#!/usr/bin/bash
source ./common.sh

# 检测先关闭容器
source ./stop.sh show_tip

# 提权后台运行容器
docker run  --rm --privileged -dit \
    -p 80:80 \
    -p 22:22 \
    --name website \
    -v $PROJECT_DIR\\nginx\\conf.d:/etc/nginx/conf.d \
    -v $PROJECT_DIR\\nginx\\nginx.conf:/etc/nginx/nginx.conf \
    -v $PROJECT_DIR\\nginx\\laravel-index.conf:/etc/nginx/laravel-index.conf \
    -v $PROJECT_DIR\\nginx\\php5.6.conf:/etc/nginx/php5.6.conf \
    -v $PROJECT_DIR\\nginx\\php7.0.conf:/etc/nginx/php7.0.conf \
    -v $PROJECT_DIR\\nginx\\php7.1.conf:/etc/nginx/php7.1.conf \
    -v $PROJECT_DIR\\nginx\\php7.2.conf:/etc/nginx/php7.2.conf \
    -v $PROJECT_DIR\\nginx\\php7.3.conf:/etc/nginx/php7.3.conf \
    -v $PROJECT_DIR\\nginx\\php7.4.conf:/etc/nginx/php7.4.conf \
    -v $PROJECT_DIR\\php\\php56\\php-fpm.d:/etc/opt/remi/php56/php-fpm.d \
    -v $PROJECT_DIR\\php\\php70\\php-fpm.d:/etc/opt/remi/php70/php-fpm.d \
    -v $PROJECT_DIR\\php\\php71\\php-fpm.d:/etc/opt/remi/php71/php-fpm.d \
    -v $PROJECT_DIR\\php\\php72\\php-fpm.d:/etc/opt/remi/php72/php-fpm.d \
    -v $PROJECT_DIR\\php\\php73\\php-fpm.d:/etc/opt/remi/php73/php-fpm.d \
    -v $PROJECT_DIR\\php\\php74\\php-fpm.d:/etc/opt/remi/php74/php-fpm.d \
    -v $PROJECT_DIR\\profile:/docker/profile.d \
    -v $PROJECT_DIR\\host\\host:/docker/hosts \
    -v $PROJECT_DIR\\crontab:/docker/crontab \
    -v $PROJECT_DIR\\boot\\boot.sh:/docker/docker_boot \
    -v $PROJECT_DIR\\supervisord:/docker/supervisord \
    -v $PROJECT_DIR\\..\\www:/www/wwwroot \
    -v $PROJECT_DIR\\cgroup:/sys/fs/cgroup \
    website | head -n 1 | cut -c1-12  > $PID_FILE

# 初始化
winpty docker exec -it $(cat $PID_FILE ) sh -c "sh /docker/docker_boot"

# 进入容器终端
echo "正在进入容器终端...."
winpty docker exec -it $(cat $PID_FILE ) bash