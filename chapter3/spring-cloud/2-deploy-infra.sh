#!/bin/bash

# 注意，执行此脚本时，命令行“工作目录”应为示例项目所在位置（然后使用完整路径引用此文件并执行）
# 示例项目源代码：https://github.com/idcf-devops-on-kubernetes/CoorAir

set -e

ITEMS='Zipkin Eureka Zuul'

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
for ITEM in $ITEMS ; do
    $SCRIPTPATH/3-deploy-service.sh $ITEM
done
