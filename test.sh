#!/usr/bin/env bash
# coding:utf-8
###
 # @Date: 2023-03-19 08:49:57
 # @Author: aiifan aiifan@126.com
 # @LastEditTime: 2023-03-19 08:50:12
 # @FilePath: /my-shell-python-script/test.sh
### 
FILE_NAME=$0
LOG_NAME=$(basename $FILE_NAME .sh)
echo ${LOG_NAME}