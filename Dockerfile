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

# 安装Nginx
WORKDIR /root
RUN rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm && \
    yum  -y install nginx

# 开放80端口
EXPOSE 80

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
    php56-php-mysqlnd php70-php-mysqlnd php72-php-mysqlnd \
    php56-php-pdo php70-php-pdo php72-php-pdo \
    php56-php-pecl-redis php70-php-pecl-redis php72-php-pecl-redis

# 复制站点文件
#ADD host/host /etc/host
#ADD nginx/* /etc/nginx/
#ADD php/5.6/fpm/www.conf /etc/opt/remi/php56/php-fpm.d/www.conf
#ADD php/7.0/fpm/www.conf /etc/opt/remi/php70/php-fpm.d/www.conf
#ADD php/7.2/fpm/www.conf /etc/opt/remi/php72/php-fpm.d/www.conf
#ADD boot/boot.sh /boot.sh
#ADD profile/profile /profile

CMD ["/usr/sbin/init"]

