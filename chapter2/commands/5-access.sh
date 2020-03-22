
# 在本地使用 Load Balancer Service 访问
kubectl get svc/video-gallery -o 'jsonpath={.status.loadBalancer.ingress[0].ip}'

# 完成域名解析

# 使用域名访问
curl video-gallery.jijiechen.com

# 安装 Ingress Controller
# docs: https://kubernetes.github.io/ingress-nginx/deploy/
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.30.0/deploy/static/mandatory.yaml
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.30.0/deploy/static/provider/cloud-generic.yaml
# 使用中国源
    kubectl apply -f https://gitee.com/idcf-devops-on-kubernetes/workshop-assets/raw/master/chapter2/assets/mandatory.yaml
    kubectl apply -f https://gitee.com/idcf-devops-on-kubernetes/workshop-assets/raw/master/chapter2/assets/cloud-generic.yaml

kubectl rollout status deploy/nginx-ingress-controller -n ingress-nginx
kubectl get ingress

# 创建 Ingress 资源
kubectl apply -f ./deployment/ingress.yaml
kubectl get ingress

# 完成域名解析

# 使用域名访问
curl video-gallery-ingress.jijiechen.com

# 如果你使用 Minikube，那么就不需要映射域名了，直接使用 <minikube-ip>.nip.io 的形式访问