#!/usr/bin/env bash
# coding:utf-8
###
 # @Date: 2023-03-19 08:41:43
 # @Author: aiifan aiifan@126.com
 # @LastEditTime: 2023-03-19 09:20:37
 # @FilePath: /my-shell-python-script/fz_isms_installer.sh
### 

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'
DIR=$(cd "$(dirname "$0")";pwd)
ERROR="ERROR"
INFO="INFO"
WARNING="WARNING"

LogCut(){
    local FILENAME=$1
    local FILESIZE=`ls -l $FILENAME | awk '{ print $5 }'`
    MAXSIZE=$((1024*1000))
    if [ $FILESIZE -gt $MAXSIZE ]
    then
        mv $FILENAME $FILENAME"`date +%Y-%m-%d_%H:%M:%S`"
    fi
}

LOG_NAME=$(basename $0 .sh)
Log()
{
    log_level=$1
    msg=$2

    if [ ! -f "/var/log/$LOG_NAME.log" ]; then
        touch /var/log/$LOG_NAME.log
    fi

    local datefmt="`date "+%Y-%m-%d %H:%M:%S"`"
    local log_info="$datefmt $log_level: $msg"
    echo "$log_info" >> /var/log/$LOG_NAME.log
    LogCut $LOG_NAME.log
}
[[ $EUID -ne 0 ]] && echo -e "[${red}Error${plain}] This script must be run as root!" && Log $ERROR "This script must be run as root"  && exit 1


SystemInit(){
    # 关闭selinux
    setenforce 0
    
    if [[ `grep -q '^SELINUX=enforcing' /etc/selinux/config` ]];then
        #sed -i 's/^SELINUX=enforcing$/SELINUX=disabled/g' /etc/selinux/config
        echo '1'
    fi
}