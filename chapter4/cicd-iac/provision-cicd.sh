#!/bin/bash

function usage() {
    echo
    echo "Usage:"
    echo " $0 [command] [options]"
    echo " $0 --help"
    echo
    echo "Example:"
    echo " $0 deploy"
    echo
    echo "COMMANDS:"
    echo "   deploy       部署 CI CD 环境"
    echo "   delete       删除 CI CD 环境"
    echo
}

ARG_COMMAND=deploy

while :; do
    case $1 in
        deploy)
            ARG_COMMAND=deploy
            ;;
        delete)
            ARG_COMMAND=delete
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        --)
            shift
            break
            ;;
        -?*)
            printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
            shift
            ;;
        *) # Default case: If no more options then break out of the loop.
            break
    esac

    shift
done

function kcd() {
  kubectl config set-context $(kubectl config current-context) --namespace $1
}

function deploy() {
  EXISTS=$(echo $NAMESPACES | grep cicd-iac)
    if [ -z "$EXISTS" ]; then
        kubectl create namespace cicd-iac || true
        sleep 2
    fi  
  
  kcd cicd-iac
  echo "正在等待部署完成，请稍候..."
  helm install lab ./ -n cicd-iac --set 'imagePushRegistry.location=ccr.ccs.tencentyun.com/idcf-k8s-devops,imagePushRegistry.username=100000627191,imagePushRegistry.password=odGJpN4onmC'
}

START=`date +%s`

case "$ARG_COMMAND" in
    delete)
        echo "Deleting..."
        helm uninstall lab
        kubectl delete namespace/cicd-iac
        echo
        echo "Delete completed successfully!"
        kcd default
        ;;
      
    deploy)
        echo "Deploying..."
        deploy
        echo
        echo "Provisioning completed successfully!"
        ;;
        
    *)
        echo "Invalid command specified: '$ARG_COMMAND'"
        usage
        ;;
esac


END=`date +%s`
echo "(Completed in $(( ($END - $START)/60 )) min $(( ($END - $START)%60 )) sec)"
echo 

