#!/bin/bash
nginx_path=/export/servers/nginx
yum install -y gcc openssl-devv libtool make automake gcc-c++
cd /usr/local/src
######install pcre#######
wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.34.tar.gz 
tar xzvf pcre-8.34.tar.gz
cd pcre-8.34
./configure
make && make install

#########install zlib##############
cd /user/local/src
wget http://zlib.net/zlib-1.2.8.tar.gz
tar xzvf zlib-1.2.8.tar.gz
cd zlib-1.2.8
./configure
make && make install

##########install nginx#############
cd /usr/local/src
wget http://nginx.org/download/nginx-1.8.1.tar.gz
tar xzvf nginx-1.8.1.tar.gz
cd nginx-1.8.1
./configure --prefix=$nginx_path 
--sbin-path=$nginx_path/sbin/nginx 
--conf-path=$nginx_path/conf/nginx.conf
--pid-path=$nginx_path/nginx.pid
--with-pcre=/usr/local/src/pcre-8.34 
--with-zlib=/usr/local/src/zlib-1.2.8 
make
make install
