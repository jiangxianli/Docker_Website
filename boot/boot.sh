#!/bin/bash

# PHP运行目录创建
if [ ! -d "/run/php" ];then
    mkdir /run/php && chown nginx.nginx /run/php
fi

# 环境变量
source /etc/profile

#启动服务
systemctl restart php56-php-fpm
systemctl restart php70-php-fpm
systemctl restart php72-php-fpm
systemctl restart nginx