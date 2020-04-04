#!/bin/bash

# 注意，执行此脚本时，命令行“工作目录”应为示例项目所在位置（然后使用完整路径引用此文件并执行）
# 示例项目源代码：https://github.com/idcf-devops-on-kubernetes/CoorAir

set -e


ARG_1=$1


SERVICES="Airports Presentation Sales Flights"
IMAGE_TAG=workshop

if [ ! -z $ARG_1 ] ; then
    SERVICES=$ARG_1
fi


kubectl create namespace sck8s 2>/dev/null || true
kubectl config set-context $(kubectl config current-context) --namespace sck8s

for SVC in $SERVICES ; do
    echo "Deploying $SVC..."
    LOWER=$(echo $SVC | tr '[:upper:]' '[:lower:]') 

    if [ -f ./$SVC/src/main/k8s/application-k8s.yml ]; then
        kubectl delete configmap/$LOWER-config 2>/dev/null || true
        kubectl create configmap $LOWER-config --from-file ./$SVC/src/main/k8s/application-k8s.yml
        kubectl label configmap $LOWER-config "app=$LOWER"
    fi

    if [ -f ./$SVC/src/main/k8s/deployment.yml ]; then
        kubectl delete deployment/$LOWER 2>/dev/null || true
        kubectl apply -f ./$SVC/src/main/k8s/deployment.yml 
    fi
done
