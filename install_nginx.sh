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
./configure --prefix=$nginx_path  --with-pcre=/usr/local/src/pcre-8.37 --with-zlib=/usr/local/src/zlib-1.2.8 --with-http_stub_status_module --with-http_gzip_static_module 
make
make install
mv /usr/local/src/nginx/logrotate.sh $nginx_path/sbin/
chmod +x $nginx_path/sbin/*
mkdir -p $nginx_path/conf/domains
echo "59 23 * * * root cd /export/servers/nginx/sbin; ./logrotate.sh" >>/etc/crontab
service crond restart
cat >>/etc/sudoers <<EOF
Defaults:admin !requiretty 
admin ALL=(ALL) NOPASSWD: /export/servers/nginx/sbin/nginx, /sbin/service, /usr/bin/pidstat
EOF
mv /usr/local/src/nginx/restart/nginx /etc/init.d/nginx
chmod +x /etc/init.d/nginx
chown -R admin:admin /export
chmod -R 755 /export
