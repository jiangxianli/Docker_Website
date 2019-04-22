FROM centos

# 开启systemctl
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN yum -y install wget

#更换YUM源
WORKDIR /etc/yum.repos.d
RUN mv CentOS-Base.repo CentOS-Base.repo.bak && \
    wget -O CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo && \
    yum clean all && \
    yum makecache && \
    yum -y update

# 安装Nginx、Git、Crontab
WORKDIR /root
RUN rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm && \
    yum  -y install nginx git  crontabs

# 开放80端口
EXPOSE 80
EXPOSE 22

# 安装PHP7
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum -y install php56 php70 php72 \
    php56-php-devel php70-php-devel php72-php-devel \
    php56-php-fpm php70-php-fpm php72-php-fpm \
    php56-php-gd php70-php-gd php72-php-gd \
    php56-php-mbstring php70-php-mbstring php72-php-mbstring \
    php56-php-mcrypt php70-php-mcrypt php72-php-mcrypt \
    php56-php-mysqlnd php70-php-mysqlnd php72-php-mysqlnd \
    php56-php-pdo php70-php-pdo php72-php-pdo \
    php56-php-pecl-redis php70-php-pecl-redis php72-php-pecl-redis \
    php70-php-bcmath php72-php-bcmath php56-php-bcmath \
    php56-php-xml php70-php-xml php72-php-xml \
    php56-php-pecl-mongodb php70-php-pecl-mongodb php72-php-pecl-mongodb \
    php56-php-pecl-gearman php70-php-pecl-gearman php72-php-pecl-gearman \
    php56-php-pecl-zip php70-php-pecl-zip  php72-php-pecl-zip \
    php56-php-process php70-php-process  php72-php-process

# 修改时区
RUN yum install -y  net-tools && \
     ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 安装composer
RUN ln -s /opt/remi/php72/root/usr/bin/php /usr/bin/php && \
    wget https://getcomposer.org/download/1.6.5/composer.phar && \
    chmod u+x composer.phar && \
    mv composer.phar /usr/bin/composer && \
    composer config -g repo.packagist composer https://packagist.laravel-china.org && \
    composer config -g secure-http false

# 建立Web项目目录
RUN mkdir -p /www/wwwroot

# 安装GOLANG
RUN wget -O go.tar.gz https://dl.google.com/go/go1.11.1.linux-amd64.tar.gz && \
    tar xzvf  go.tar.gz && mv go /usr/local/src/ && rm -rf go.tar.gz

# 安装Supervisor、sshd、gearmand
RUN yum install -y  supervisor openssh-server gearmand  sudo zip unzip redis && \
    sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config && \
    echo "root:root" | chpasswd && \
    ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key && \
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    mkdir /var/run/sshd

RUN yum install -y  nfs-utils psmisc bzip2.x86_64 bitmap-fonts bitmap-fonts-cjk mkfontscale fontconfig

# 安装NodeJs
RUN wget https://npm.taobao.org/mirrors/node/v10.15.0/node-v10.15.0-linux-x64.tar.xz && \
    tar xf  node-v10.15.0-linux-x64.tar.xz -C /usr/local/ && \
    ln -s /usr/local/node-v10.15.0-linux-x64/bin/node /usr/local/bin/ && \
    ln -s /usr/local/node-v10.15.0-linux-x64/bin/npm /usr/local/bin/ && \
    npm config set registry https://registry.npm.taobao.org

# 解决vi编辑器中文乱码
RUN echo "set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936" >> /etc/virc && \
    echo "set termencoding=utf-8" >> /etc/virc && \
    echo "set encoding=utf-8" >> /etc/virc

# 内网穿透软件下载
RUN wget https://www.ngrok.cc/sunny/php-ngrok.zip && unzip php-ngrok.zip

# 安装Mysql
RUN wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm && \
    rpm -ivh mysql57-community-release-el7-9.noarch.rpm && \
    yum install -y mysql-server

ENTRYPOINT ["/usr/sbin/init"]

