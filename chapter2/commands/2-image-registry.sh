
# 登录到 Docker Hub
docker login -u jijiechen -p $DOCKER_PASSWORD

# Tag 标记并推送到 Docker Hub
docker tag video-gallery:v2 jijiechen/video-gallery:v2
docker push jijiechen/video-gallery:v2

# 在两个控制台中，分别从 Docker Hub 和 镜像服务器拉取
docker pull jijiechen/video-gallery:v2
docker pull dockerhub.azk8s.cn/jijiechen/video-gallery:v2

# 登录到自有镜像仓库，Tag 标记，并推送
docker login -u 100000627191 -p $TENCENT_PASSWORD ccr.ccs.tencentyun.com
docker tag video-gallery:v2 ccr.ccs.tencentyun.com/idcf-k8s-devops/video-gallery:v2
docker push ccr.ccs.tencentyun.com/idcf-k8s-devops/video-gallery:v2