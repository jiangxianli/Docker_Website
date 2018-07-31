#!/bin/bash

# PHP运行目录创建
if [ ! -d "/run/php" ];then
    mkdir /run/php && chown nginx.nginx /run/php
fi

# 环境变量
source /etc/profile

# 解决UID不一致问题
uid=`ls -l /www | grep wwwroot | awk -F" " '{print $3}'`
if [ "$uid" -gt 0 ] 2>/dev/null ;then
    usermod -u  $uid nginx
fi

#启动服务
systemctl restart php56-php-fpm
systemctl restart php70-php-fpm
systemctl restart php72-php-fpm
systemctl restart nginx