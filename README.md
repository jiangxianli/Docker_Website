# Docker搭建PHP集成环境
使用Dockerfile构建Centos一体化PHP镜像，开发人员无需关注环境搭建问题，可以上手部署项目进行开发。
```
├─boot
│  │  boot.sh #Centos系统服务启动命令 => 挂载到/usr/bin/docker_boot
│  ├─linux # Linux环境使用脚本
│  │      build.sh #编译Dockerfile 构建Centos镜像
│  │      start.sh #启动容器
│  │      stop.sh  #停止容器
│  └─windows # Windows环境使用脚本
│          build.sh #编译Dockerfile 构建Centos镜像
│          start.sh #启动容器
│          stop.sh #停止容器
├─host
│      host # host => 挂载到/etc/hosts
├─nginx
│  │  nginx.conf => 挂载到/etc/nginx/nginx.conf
│  └─conf.d => 目录挂载到/etc/nginx/conf.d
├─php
│  ├─5.6
│  │  └─fpm
│  │          www.conf # PHP5.6 fpm配置文件  => 挂载到/etc/opt/remi/php56/php-fpm.d/www.conf
│  ├─7.0
│  │  └─fpm
│  │          www.conf # PHP7.0 fpm配置文件=> 挂载到/etc/opt/remi/php70/php-fpm.d/www.conf
│  └─7.2
│      └─fpm
│              www.conf # PHP7.2 fpm配置文件 => 挂载到/etc/opt/remi/php72/php-fpm.d/www.conf
├─profile
│      profile # 环境变量配置 => 挂载到/etc/profile
│
└─www # 项目代码目录 => 挂载到/www/wwwroot
        .gitignore 
```