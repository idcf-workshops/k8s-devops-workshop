
# 部署应用
kubectl apply -f ./deployment/deployment.yaml

# 观察 Pod 启动过程
kubectl get pods -w
kubectl rollout status deploy/video-gallery

# 在本地访问 Pod（在第2个控制台）
kubectl port-forward pods/pod-id 5000:80




# 删除 Pod（在第2个控制台）
kubectl delete pods/pod-id

# 观察 Pod 启动过程

# 在本地访问 Pod（在第2个控制台）
kubectl port-forward pods/pod-id2

# 在本地使用 Load Balancer Service 访问
kubectl get svc/video-gallery -o 'jsonpath={.status.loadBalancer.ingress[0].ip}'

# 增加 storage
# 重新部署 Deployment


# 增加 Probe
# 重新部署 Deployment





