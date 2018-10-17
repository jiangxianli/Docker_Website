# Docker搭建PHP集成环境
使用Dockerfile构建CentOs一体化PHP环境镜像，开发人员无需关注环境搭建问题，可以上手部署项目进行开发。

## 目录介绍
### boot 目录 【容器构建、启动、关闭】
> 根据您当前使用的宿主主机系统选择对应的Linux/Windows目录，进入到目录中。

> `sh build.sh` - 编译Dockerfile构建镜像

> `sh start.sh` - 使用镜像构建容器，运行容器并进入到容器终端

> `sh console.sh` - 容器启动后，执行此命令可进入到容器终端

> `sh stop.sh` - 关闭已启动的容器

### crontab 目录 【定时任务配置】
> 此目录是定时任务的配置文件存放目录，以容器中对应的用户名命名文件，如root文件 则是以root 用户来运行此定时任务配置文件。

> root:
```shell
* * * * * echo 'test' >> /tmp/1.txt
```
> 注：在此目录中更改文件后，需在容器中执行`docker_boot`命令后 更改才会生效。

### nginx 目录 【Nginx站点配置文件】
> conf.d 目录中存放 站点配置文件 ；目录中已配置好laravel-index.conf,php5.6.conf,php7.0.conf,php7.2.conf 文件可以引用。
一般基础的站点配置如下：
```nginx
server {

    #域名配置
    server_name  retail.plan.web.sscf.com ;

    #项目目录
    root /www/wwwroot/retail_plan_web/www/retail.plan.web.sscf.com/public;

    #主文件定义
    index index.php index.html index.htm;

    #定义Laravel路由规则
    include laravel-index.conf;
   
    #使用PHP7.2
    include php7.2.conf;

}
```
> 注：在此目录中更改文件后，需在容器中执行`docker_boot`命令后 更改才会生效。

### PHP 目录 【PHP多版本配置文件】
> 注：在此目录中更改文件后，需在容器中执行`docker_boot`命令后 更改才会生效。


### profile 目录 【环境变量配置】
> 注：在此目录中更改文件后，需在容器中执行`docker_boot`命令后 更改才会生效。

### supervisord 目录 【守护进程配置】
> 注：在此目录中更改文件后，需在容器中执行`docker_boot`命令后 更改才会生效。


### www 目录 【网站项目目录】
> 此目录映射到容器中的/www/wwwroot ,所以在nginx的站点配置root 配置路径为/www/wwwroot/xxxproject/xxx

## 使用
 - Windows 使用 Git Bash ,进入到boot/windows 目录 。需要配置`环境变量DOCKER_PROJECT_DIR`路径为本项目的根目录。
 - Linux 使用 终端 进入到 boot/linux  
 - 执行 `sh build.sh` 编译Dockerfile 构建镜像
 - 执行 `sh start.sh` 启动容器，启动的容器ID 存储在docker.pid文件中,启动成功后会进入到容器中的命令行。
 - 执行 `sh stop.sh` 来停止容器运行。
 
## Windows 下使用Docker 注意事项
- 使用Docker , 请安装 Docker for Windows10
- 【控制面板】 - 【程序和功能】 - 【启用或关闭Windows功能】 中，勾选上`Hyper-V`，确定重启。
-  Docker - 【Settings】 - 【Shared Drivers】 勾选上分享的盘符，点确定。
 
 
