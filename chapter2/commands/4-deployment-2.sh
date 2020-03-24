
# 将应用的部署副本数增加到 10
kubectl scale deployment/video-gallery --replicas=10

# 查看 Pod 启动的情况
kubectl get pods -w

# 关停网站
kubectl scale deployment/video-gallery --replicas=0


# 查看 API 响应情况
while true ; do curl http://$IP/videos ; sleep .5 ; done

# 升级版本（更改 ./deployment/deployment.yaml 中的 image 设置）
kubectl apply -f ./deployment/deployment.yaml

# 查看 Pod 的创建过程
kubectl get pods -w