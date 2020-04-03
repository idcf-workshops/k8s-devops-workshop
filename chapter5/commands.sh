

# 绑定 Helm 依赖
# helm repo add stable https://mirror.azure.cn/kubernetes/charts/
# helm repo add kiwigrid https://kiwigrid.github.io/
# helm dependency build ./logging
# helm dependency build ./monitoring

kubectl create namespace logging
helm install logging -n logging ./logging


kubectl create namespace monitoring
helm install monitoring -n monitoring ./monitoring


# curl -O -L https://mirror.azure.cn/kubernetes/charts-incubator/metrics-server-2.0.4.tgz && tar -zxf metrics-server-2.0.4.tgz && rm metrics-server-2.0.4.tgz
# helm template metrics-server ./metrics-server --set 'image.repository=gcr.io/google_containers/metrics-server-amd64,args={--kubelet-insecure-tls}' -n kube-system | kubectl apply -f -


# Dashboard: Cluster Monitoring for Kubernetes
# k8s-app-metrics.json
# node -p 'while(true){}'