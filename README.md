# Docker搭建PHP集成环境
使用Dockerfile构建Centos一体化PHP镜像，开发人员无需关注环境搭建问题，可以上手部署项目进行开发。

## 目录介绍
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
## 使用
 - Windows 使用 Git Bash ,进入到boot/windows 目录 。需要配置`环境变量DOCKER_PROJECT_DIR`路径为本项目的根目录。
 - Linux 使用 终端 进入到 boot/linux  
 - 执行 `sh build.sh` 编译Dockerfile 构建镜像
 - 执行 `sh start.sh` 启动容器，启动的容器ID 存储在docker.pid文件中,启动成功后会进入到容器中的命令行，也就是Centos系统中的终端中。这时要执行
 `docker_boot` 命令 来启动系统服务（如PHP、Nginx）.如果你修改了nginx\php 目录下的配置，也需要在容器命令行中再次执行`docker_boot`来使其生效。
 - 执行 `sh stop.sh` 来停止容器运行。
 
