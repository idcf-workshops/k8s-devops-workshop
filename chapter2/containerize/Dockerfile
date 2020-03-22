FROM mcr.azk8s.cn/dotnet/core/runtime:3.1
RUN apt update && apt install -y ffmpeg


WORKDIR /app
COPY ./publish /app

ENV TZ=Asia/Shanghai

ENV ASPNETCORE_ENVIRONMENT=Production
ENTRYPOINT ["dotnet", "./VideoGallery.dll"]