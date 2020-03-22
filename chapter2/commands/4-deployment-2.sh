
# 将应用的部署副本数增加到 10
kubectl scale replica=10 deployment/video-gallery

# 查看 Pod 启动的情况
kubectl get pods -w

# 关停网站
kubectl scale replica=0 deployment/video-gallery


# 升级版本 todo