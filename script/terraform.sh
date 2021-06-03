#!/bin/bash

# 定义主机数量，超过这个数，就自动退出脚本
number=2

path='/opt/terraform-learning/'
compartmentID=`oci iam availability-domain list | grep 'compartment-id' |awk -F '"'  '{print $4}'`

cd $path &&

while true
do
    instancesNu=`oci compute instance list --compartment-id $compartmentID --lifecycle-state RUNNING | grep 'lifecycle-state' | wc -l`
    if [ $instancesNu -lt $number ]; then
        
        echo 'yes' | terraform apply
    else
        echo -e "Instances 数量已超过你设置的最大值："["\033[31m${number}\033[0m"], 脚本自动停止。
        break
    fi
done
exit 0
