#!/bin/bash
source ./common.sh

# 检测先关闭容器
source ./stop.sh show_tip

# 提权后台运行容器
docker run  --rm --privileged -dit \
    -p 80:80 \
    -p 22:22 \
    --mount type=bind,source="$PROJECT_DIR/nginx/nginx.conf",target="/etc/nginx/nginx.conf" \
    --mount type=bind,source="$PROJECT_DIR/nginx/laravel-index.conf",target="/etc/nginx/laravel-index.conf" \
    --mount type=bind,source="$PROJECT_DIR/nginx/php5.6.conf",target="/etc/nginx/php5.6.conf" \
    --mount type=bind,source="$PROJECT_DIR/nginx/php7.0.conf",target="/etc/nginx/php7.0.conf" \
    --mount type=bind,source="$PROJECT_DIR/nginx/php7.2.conf",target="/etc/nginx/php7.2.conf" \
    --mount type=bind,source="$PROJECT_DIR/nginx/conf.d",target="/etc/nginx/conf.d" \
    --mount type=bind,source="$PROJECT_DIR/php/5.6/fpm/www.conf",target="/etc/opt/remi/php56/php-fpm.d/www.conf" \
    --mount type=bind,source="$PROJECT_DIR/php/7.0/fpm/www.conf",target="/etc/opt/remi/php70/php-fpm.d/www.conf" \
    --mount type=bind,source="$PROJECT_DIR/php/7.2/fpm/www.conf",target="/etc/opt/remi/php72/php-fpm.d/www.conf" \
    --mount type=bind,source="$PROJECT_DIR/profile/profile.sh",target="/etc/profile.d/profile.sh" \
    --mount type=bind,source="$PROJECT_DIR/host/host",target="/www/hosts" \
    --mount type=bind,source="$PROJECT_DIR/crontab",target="/www/crontab" \
    --mount type=bind,source="$PROJECT_DIR/supervisord",target="/www/supervisord" \
    --mount type=bind,source="$PROJECT_DIR/boot/boot.sh",target="/www/boot.sh" \
    website | cut -c1-12 > $PID_FILE

# 初始化
docker exec -it $(cat $PID_FILE ) sh -c "sh /www/boot.sh"

# 进入容器终端
echo "正在进入容器终端...."
docker exec -it $(cat $PID_FILE ) /bin/bash