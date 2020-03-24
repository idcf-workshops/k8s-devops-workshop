#!/bin/bash

set -e

REPO=$1
PUSH=$2

docker pull dockerhub.azk8s.cn/library/mysql:5.6
docker tag dockerhub.azk8s.cn/library/mysql:5.6 ${REPO}boat-house-mysql:5.6

docker pull dockerhub.azk8s.cn/library/postgres:9.4
docker tag dockerhub.azk8s.cn/library/postgres:9.4 ${REPO}boat-house-postgres:9.4

docker pull dockerhub.azk8s.cn/library/redis:alpine
docker tag dockerhub.azk8s.cn/library/redis:alpine ${REPO}boat-house-redis:alpine




if [ ! -z $PUSH ] ; then
    docker push ${REPO}boat-house-mysql:5.6
    docker push ${REPO}boat-house-postgres:9.4
    docker push ${REPO}boat-house-redis:alpine
fi