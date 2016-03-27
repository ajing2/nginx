#!/bin/bash
nginx_path=/export/servers/nginx
mkdir -p $nginx_path
yum install -y gcc openssl-devv libtool make automake gcc-c++
cd /usr/local/src/nginx
######install pcre#######
#wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.37.tar.gz 
cp pcre-8.37.tar.gz ..
cd ..
tar xzvf pcre-8.37.tar.gz
cd pcre-8.37
./configure
make
make install

#########install zlib##############
cd /usr/local/src/nginx
#wget http://zlib.net/zlib-1.2.8.tar.gz
cp zlib-1.2.8.tar.gz ..
cd ..
tar xzvf zlib-1.2.8.tar.gz
cd zlib-1.2.8
./configure
make && make install

##########install nginx#############
cd /usr/local/src/nginx
#wget http://nginx.org/download/nginx-1.8.1.tar.gz
tar xzvf nginx-1.8.1.tar.gz
cd nginx-1.8.1
./configure --prefix=$nginx_path  --with-pcre=/usr/local/src/pcre-8.37 --with-zlib=/usr/local/src/zlib-1.2.8 
make
make install
mv /usr/local/src/nginx/logrotate.sh $nginx_path/sbin/
chmod +x $nginx_path/sbin/*
echo "59 23 * * * root cd /export/servers/nginx/sbin; ./logrotate.sh" >>/etc/crontab
