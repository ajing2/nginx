#!/bin/bash
LOG_DIR="/export/servers/nginx/logs"
BACK_DIR=`date +%Y/%m/`  
DATE_NAME=`date +%Y%m%d `
cd $LOG_DIR
for log in access.log error.log
do
mv ${LOG_DIR}/$log ${LOG_DIR}/$log${DATE_NAME}
done
find * -mtime +10 -type f -exec rm -f {} \;
kill -USR1 `cat  /export/servers/nginx/run/nginx.pid`
