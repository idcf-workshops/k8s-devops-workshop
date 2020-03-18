
查看集群信息
    kubectl cluster-info

创建网站
    kubectl create -f ./hello-kubernetes/static-site.yaml

查看启动过程
    kubectl get pods -w

端口转发到本地
    kubectl port-forward pods/static-site 9000:80

在本地查看网站
    curl localhost:9000

查看 Pod 的日志
    kubectl logs pods/static-site

把服务公开给外界访问
    kubectl expose pods/static-site --type NodePort

查看服务端口
    kubectl get services/static-site

示例集群节点的 IP 地址：
    - 192.144.144.246
    - 140.143.251.142
    - 140.143.229.50

删除示例
    kubectl delete pod/static-site svc/static-site
