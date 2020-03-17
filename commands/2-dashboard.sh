
kubectl config set-context $(kubectl config current-context) --namespace 

安装 dashboard（40s）
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml

启用代理：
    kubectl proxy

访问网址：
    http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

获取本地用户 Token
    kubectl config view –o jsonpath=‘{.users[*].user.token}'
