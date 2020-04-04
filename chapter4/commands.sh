

# 部署 Joomla
helm install cms stable/joomla --set "joomlaUsername=admin,joomlaPassword=password,mariadb.mariadbRootPassword=$(echo -n $(openssl rand -hex 5)),persistence.enabled=false,image.pullPolicy=IfNotPresent"


# 部署微服务基础设施到 boathouse-prod
./deploy-infra.sh prod

# 切换到 boathouse-prod 命名空间，并查看微服务基础设施部署情况 (kcd boathouse-prod)
kubectl config set-context $(kubectl config current-context) --namespace boathouse-prod
kubectl get deploy -w

# 部署微服务到 boathouse-prod（可直接使用本文件所在目录。录播视频中，工作目录使用的是 boat-house 项目目录，请忽略）
helm install services ./boathouse-chart --namespace boathouse-prod \
  --set "imageNamePrefix=boat-house-,imageTag=workshop,imageRepository=ccr.ccs.tencentyun.com/idcf-k8s-devops"

# 部署 CICD 基础设施
# 如果没有私有仓库，则请不要指定对应的参数；同时，在 CI 过程中，无法将容器推送到镜像仓库
cd cicd-iac
./provision-cicd.sh deploy --registry <私有镜像仓库> --registry-username <私有镜像仓库用户名> --registry-password <私有镜像仓库密码>

# 访问 gogs 并克隆代码
git clone http://gogs-host-name/gogs/boat-house.git

# 修改代码并推送代码（用户名和密码都是 gogs）
git push origin master

# 访问 Jenkins 并观察持续交付流水线被自动触发（可修改 Jenkins 任务，用户名和密码都是 admin）
http://jenkins-host-name/job/boat-house/

# 删除 CICD 基础设施 
./provision-cicd.sh delete




