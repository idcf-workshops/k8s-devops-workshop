
# 登录到 Docker Hub
docker login -u <你的用户名> -p <你的密码>

# Tag 标记并推送到 Docker Hub
docker tag video-gallery:v2 <你的用户名>/video-gallery:v2
docker push <你的用户名>/video-gallery:v2

# 在两个控制台中，分别从 Docker Hub 和 镜像服务器拉取
docker pull <你的用户名>/video-gallery:v2
docker pull <你的用户名>/video-gallery:v2

# 登录到自有镜像仓库，Tag 标记，并推送
docker login -u <你的用户名> -p <你的密码> ccr.ccs.tencentyun.com
docker tag video-gallery:v2 ccr.ccs.tencentyun.com/idcf-k8s-devops/video-gallery:v2
docker push ccr.ccs.tencentyun.com/idcf-k8s-devops/video-gallery:v2