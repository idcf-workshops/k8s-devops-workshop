#!/bin/bash

set -e

ITEMS='Zipkin Eureka Zuul'

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
for ITEM in $ITEMS ; do
    $SCRIPTPATH/3-deploy-service.sh $ITEM
done
