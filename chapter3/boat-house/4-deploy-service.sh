#!/bin/bash

# 注意，执行此脚本时，命令行“工作目录”应为示例项目所在位置（然后使用完整路径引用此文件并执行）
# 示例项目源代码：https://github.com/idcf-boat-house/boat-house

set -e

ARG_1=$1
ARG_2=$2
ARG_3=$3


SERVICES='client management statistics-service-api statistics-service-worker product-service-api account-service-api'
IMAGE_TAG=workshop
ENV=test
REPO=ccr.ccs.tencentyun.com/idcf-k8s-devops/

if [ ! -z $ARG_1 ] ; then
    SERVICES=$ARG_1
fi
if [ ! -z $ARG_2 ] ; then
    IMAGE_TAG=$ARG_2
fi
if [ ! -z $ARG_3 ] ; then
    ENV=$ARG_3
fi


function replace(){
    FILE=$1
    BRANCH_BUILD=$2

    sed "s;docker.pkg.github.com/#{BOATHOUSE_ORG_NAME}#/boat-house/;${REPO}boat-house-;g" $FILE | \
    sed "s/#{env.BRANCH_NAME}#-#{env.BUILD_ID}#/${BRANCH_BUILD}/g"
}

function deploy(){
    SERVICE=$1

    kubectl delete deploy/$SERVICE 2>/dev/null || true
    kubectl delete deploy/${SERVICE}-deployment 2>/dev/null || true

    if [ -f ./kompose/$ENV/$SERVICE-deployment.yaml ]; then
        replace ./kompose/$ENV/$SERVICE-deployment.yaml $IMAGE_TAG | kubectl apply -f -
    fi

    if [ -f ./kompose/$ENV/$SERVICE-svc.yaml ]; then
        # echo "kubectl apply -f ./kompose/$ENV$SERVICE-svc.yaml"
        kubectl apply -f ./kompose/$ENV/$SERVICE-svc.yaml
    fi
}


kubectl create namespace boathouse-$ENV 2>/dev/null || true
for SVC in $SERVICES ; do
    echo "Deploying $SVC..."
    deploy $SVC
done