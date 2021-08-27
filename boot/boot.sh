#!/bin/bash

# 挂载目录给读写权限
mount -o remount -rw  /www/wwwroot
mount -o remount -rw  /etc/hosts

`[[ $(type -t cp) == "alias" ]] && unalias cp`

# 环境变量
cp -rf /docker/profile.d/* /etc/profile.d/ && source /etc/profile

# PHP运行目录创建
if [ ! -d "/run/php" ];then
    mkdir /run/php && chown nginx.nginx /run/php
fi

# docker脚本文件
cp -f /docker/docker_boot /usr/bin/docker_boot && chmod u+x /usr/bin/docker_boot

# 复制cron文件
cp -r /docker/crontab/* /var/spool/cron/ && chmod -R 0600 /var/spool/cron/

# 复制supervisor文件
cp -r /docker/supervisord/* /etc/supervisord.d/

# 复制HOST
cp -f /docker/hosts /etc/

chown -R nginx.nginx /var/opt/remi/php56/lib/php/session
chown -R nginx.nginx /var/opt/remi/php70/lib/php/session
chown -R nginx.nginx /var/opt/remi/php71/lib/php/session
chown -R nginx.nginx /var/opt/remi/php72/lib/php/session
chown -R nginx.nginx /var/opt/remi/php73/lib/php/session
chown -R nginx.nginx /var/opt/remi/php74/lib/php/session

#启动服务
systemctl restart php56-php-fpm
systemctl restart php70-php-fpm
systemctl restart php71-php-fpm
systemctl restart php72-php-fpm
systemctl restart php73-php-fpm
systemctl restart php74-php-fpm
systemctl restart redis
systemctl restart mysqld
systemctl restart nginx
systemctl restart sshd
systemctl restart crond
systemctl restart supervisord