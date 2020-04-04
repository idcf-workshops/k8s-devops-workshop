#!/bin/bash

# 课后练习时，无需执行此文件
# 示例项目源代码：https://github.com/idcf-devops-on-kubernetes/CoorAir

set -e

PUSH=$1
SERVICES="Airports Eureka Presentation Sales Zuul Flights"


mvn clean package
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
for SVC in $SERVICES ; do
    LOWER=$(echo $SVC | tr '[:upper:]' '[:lower:]')
    JARFILE=$(ls $SVC/target/*.jar | cut -d '/' -f 3)
    docker build -f $SCRIPTPATH/Dockerfile --build-arg="JARFILENAME=$JARFILE" \
     -t ccr.ccs.tencentyun.com/idcf-k8s-devops/sc-$LOWER:v1 ./$SVC
     
    if [ ! -z $PUSH ] ; then
        docker push ccr.ccs.tencentyun.com/idcf-k8s-devops/sc-$LOWER:v1
    fi
done


