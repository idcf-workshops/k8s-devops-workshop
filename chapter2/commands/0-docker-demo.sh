
# 在 Windows 电脑上，可以用 git bash

# 使用 Docker 运行 Jenkins
docker run -p 8080:8080 --rm -e 'JAVA_OPTS="-Djenkins.install.runSetupWizard=false"' dockerhub.azk8s.cn/jenkins/jenkins:latest

# 使用 Docker 运行 mattermost 聊天软件
docker run --rm --publish 8065:8065 mattermost/mattermost-preview
# docker run --rm --publish 8065:8065 dockerhub.azk8s.cn/mattermost/mattermost-preview




