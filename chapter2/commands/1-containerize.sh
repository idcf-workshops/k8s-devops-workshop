
git clone https://github.com/idcf-devops-on-kubernetes/video-gallery.git
docker build -t video-gallery:v2 .

# 运行 VideoGalllery
docker run --rm -p 5000:80 video-gallery:v1
curl http://localhost:5000

# 以"开发模式"运行 Video Gallery
docker run --rm -e 'ASPNETCORE_ENVIRONMENT=Development' -p 5000:80 video-gallery:v1
curl http://localhost:5000
