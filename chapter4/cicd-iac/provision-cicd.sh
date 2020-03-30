#!/bin/bash

echo "##################################"
echo "#  MAKE SURE YOU ARE LOGGED IN:  #"
echo "#  kubectl cluster-info   #"
echo "##################################"

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
    echo "   deploy         Set up the demo projects and deploy demo apps"
    echo "   delete         Clean up and remove demo projects and objects"
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


################################################################################
# CONFIGURATION                                                                #
################################################################################



NAMESPACES=$(kubectl get namespaces)

create_ns(){
    local NAME
    NAME=$1
    EXISTS=$(echo $NAMESPACES | grep $NAME)
    if [ -z "$EXISTS" ]; then
        kubectl create namespace $NAME || true
    fi
}

#   jenkins: 0.5G 2G
#   gogs: 0.5G 1G
#   sonarqube: 1.25G 2.5G
#   nexus: 0.5G 2Gi
function deploy() {
    create_ns cicd-iac

  sleep 2

  echo 'Provisioning applications...'
  kcd cicd-iac
  
  ./tmpl.sh ./manifests/jenkins.yaml ./manifests/vars | kubectl apply -f -
  sleep 3

  ./tmpl.sh ./manifests/sonarqube.yaml ./manifests/vars | kubectl apply -f -
  sleep 3

  ./tmpl.sh ./manifests/nexus.yaml ./manifests/vars | kubectl apply -f -
  sleep 3

  ./tmpl.sh ./manifests/gogs.yaml ./manifests/vars | kubectl apply -f -
  sleep 3

  echo "Provisioning installer"
  ./tmpl.sh ./manifests/cicd-installer.yaml ./manifests/vars | kubectl apply -f -

  echo "Wait for installing..."
  sleep 3
  kubectl wait --for=condition=complete --timeout=900s job/cicd-installer

  kubectl logs pods/$(kubectl get pods -o=jsonpath='{.items[0].metadata.name}' -l job-name=cicd-installer)
}

function kcd() {
  kubectl config set-context $(kubectl config current-context) --namespace $1
}

function echo_header() {
  echo
  echo "##############################"
  echo $1
  echo "##############################"
}

################################################################################
# MAIN: DEPLOY Workshop                                                   #
################################################################################


START=`date +%s`

echo_header "DevOps on Kubernetes ($(date))"

case "$ARG_COMMAND" in
    delete)
        echo "Delete demo..."
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
        kcd cicd-iac
        ;;
        
    *)
        echo "Invalid command specified: '$ARG_COMMAND'"
        usage
        ;;
esac


END=`date +%s`
echo "(Completed in $(( ($END - $START)/60 )) min $(( ($END - $START)%60 )) sec)"
echo 

