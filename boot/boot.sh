#!/bin/bash

# PHP运行目录创建
if [ ! -d "/run/php" ];then
    mkdir /run/php && chown nginx.nginx /run/php
fi

chmod u+x /www/boot.sh

if [ ! -f "/usr/bin/docker_boot" ];then
    ln -s /www/boot.sh /usr/bin/docker_boot
fi

# 环境变量
source /etc/profile

`[[ $(type -t cp) == "alias" ]] && unalias cp`

# 复制cron文件
cp -r /www/crontab/* /var/spool/cron/
chmod -R 0600 /var/spool/cron/

# 复制supervisor文件
cp -r /www/supervisord/* /etc/supervisord.d/

# 复制HOST
cp -f /www/hosts /etc/

#启动服务
systemctl restart php56-php-fpm
systemctl restart php70-php-fpm
systemctl restart php72-php-fpm
systemctl restart nginx
systemctl restart sshd
systemctl restart crond
systemctl restart supervisord