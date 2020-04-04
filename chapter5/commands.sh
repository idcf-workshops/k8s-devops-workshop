

# 绑定 Helm 依赖
# helm repo add stable https://mirror.azure.cn/kubernetes/charts/
# helm repo add kiwigrid https://kiwigrid.github.io/
# helm dependency build ./logging
# helm dependency build ./monitoring

# 安装 logging EFK
kubectl create namespace logging
helm install logging -n logging ./logging

# 访问 Joomla 并生成大量日志
while true ; do curl http://$joomla_url >/dev/null 2>/dev/null ; echo ; sleep .1 ; done

# 通过 Kibana 查看 Joomla 日志
kubectl port-forward -n logging svc/logging-kibana 5601:443
kubernetes.namespace_name:default AND kubernetes.container_name:joomla





# 安装 monitoring Prometheus Grafana
kubectl create namespace monitoring
helm install monitoring -n monitoring ./monitoring

# 访问 Prometheus 并查询
kubectl -n monitoring port-forward svc/monitoring-prometheus-server 9090:80

# 访问 Grafana 并使用看板
kubectl -n monitoring port-forward svc/monitoring-grafana 3000:80
kubectl get secret monitoring-grafana -n monitoring  -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

# k8s-app-metrics.json
# node -p 'while(true){}'

# 体验 AlertManager
kubectl -n monitoring port-forward svc/monitoring-prometheus-alertmanager 9093:80



# Kubernetes 内置 HPA 需要使用 Metrics Server
# curl -O -L https://mirror.azure.cn/kubernetes/charts-incubator/metrics-server-2.0.4.tgz && tar -zxf metrics-server-2.0.4.tgz && rm metrics-server-2.0.4.tgz
# helm template metrics-server ./metrics-server --set 'image.repository=gcr.io/google_containers/metrics-server-amd64,args={--kubelet-insecure-tls}' -n kube-system | kubectl apply -f -
