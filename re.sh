#!/usr/bin/env bash
# coding:utf-8
###
 # @Date: 2023-03-14 10:35:32
 # @Author: aiifan aiifan@126.com
 # @LastEditTime: 2023-03-14 11:45:21
 # @FilePath: /my-shell-python-script/re.sh
### 
# 定时dig DNS根，防止waj测试时出现54接口：本地副本和国际根的解析量同时为0现象


DIR=$(cd "$(dirname "$0")";pwd)

ERROR="ERROR"
INFO="INFO"
WARNING="WARNING"
Log()
{
    log_level=$1
    msg=$2

    if [ ! -f "$DIR/re-dig-root.log" ]; then
        touch $DIR/re-dig-root.log
    fi
    local datefmt="`date "+%Y-%m-%d %H:%M:%S"`"
    local log_info="$datefmt $log_level: $msg"
    echo "$log_info" >> $DIR/re-dig-root.log
}
#ROOTLIST=('j.root-servers.net')
ROOTLIST=('a.root-servers.net' 'b.root-servers.net' 'c.root-servers.net' 'd.root-servers.net' 'e.root-servers.net' 'f.root-servers.net' 'g.root-servers.net' 'h.root-servers.net' 'i.root-servers.net' 'j.root-servers.net' 'k.root-servers.net' 'l.root-servers.net' 'm.root-servers.net')
DNSSERVER=('222.88.88.100' '222.85.85.100')

digRoot(){
    res=`dig @$1 $2 | grep "^$2" | awk '{print $NF}'`
    #echo $res
    if [[ ! -z $res ]];then
        Log $INFO "$1 : $2 -> $res"
    else
        Log $WARNING "$1 : $2 analysis failed!"
    fi
}

for rootdomain in ${ROOTLIST[@]};do
    for dns_server in ${DNSSERVER[*]};do
        digRoot $dns_server $rootdomain &
    done
done
wait