VELOCITY_JAR_URL=https://api.papermc.io/v2/projects/velocity/versions/3.2.0-SNAPSHOT/builds/265/downloads/velocity-3.2.0-SNAPSHOT-265.jar

if curl $VELOCITY_JAR_URL; then
else
    echo "failed to download the velocity from $VELOCITY_JAR_URL"
    exit 1
fi
# 提取文件名
FILENAME=$(basename $URL)

# 从文件名中提取版本号
VERSION=$(echo $FILENAME | grep -oP 'velocity-\K[^-]+' | sed 's/.jar//g')
echo "Version: $VERSION"

sudo docker login -u ${DOCKER_USERNAME} -P ${DOCKER_PASSWORD}
sudo docker build -t velocity:${VERSION} .
sudo docker tag velocity:${VERSION} mythoscode/velocity:latest
sudo docker push mythoscode/velocity:${VERSION}

exit 0