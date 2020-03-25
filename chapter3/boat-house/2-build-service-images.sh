#!/bin/bash

#示例项目：https://github.com/idcf-boat-house/boat-house

set -e

REPO=$1
PUSH=$2

docker build -f ./client/web/Dockerfile -t ${REPO}boat-house-client:workshop client/web
docker build -f ./management/web/Dockerfile -t ${REPO}boat-house-management:workshop management/web
docker build -f ./statistics-service/api/Dockerfile -t ${REPO}boat-house-statistics_service_api:workshop statistics-service/api
docker build -f ./statistics-service/worker/Dockerfile -t ${REPO}boat-house-statistics_service_worker:workshop statistics-service/worker

docker-compose -f ./product-service/api/docker-compose.build.yaml up
docker build -f ./product-service/api/Dockerfile.image -t ${REPO}boat-house-product_service_api:workshop product-service/api
docker-compose -f ./product-service/api/docker-compose.build.yaml stop

docker-compose -f ./account-service/api/docker-compose.build.yaml up
docker build -f ./account-service/api/Dockerfile.image -t ${REPO}boat-house-account_service_api:workshop account-service/api
docker-compose -f ./account-service/api/docker-compose.build.yaml stop


if [ ! -z $PUSH ] ; then
    docker push ${REPO}boat-house-client:workshop
    docker push ${REPO}boat-house-management:workshop
    docker push ${REPO}boat-house-statistics_service_api:workshop
    docker push ${REPO}boat-house-statistics_service_worker:workshop
    docker push ${REPO}boat-house-product_service_api:workshop
    docker push ${REPO}boat-house-account_service_api:workshop
fi