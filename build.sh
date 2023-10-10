VELOCITY_JAR_URL=https://api.papermc.io/v2/projects/velocity/versions/3.2.0-SNAPSHOT/builds/269/downloads/velocity-3.2.0-SNAPSHOT-269.jar

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 DOCKER_USERNAME DOCKER_PASSWORD"
    exit 1
fi

DOCKER_USERNAME="$1"
DOCKER_PASSWORD="$2"

if curl -O $VELOCITY_JAR_URL; then
    FILENAME=$(basename $VELOCITY_JAR_URL)

    VERSION=$(echo "$FILENAME" | sed 's/.jar$//;s/^velocity-//')
    echo "Version: $VERSION"

    sudo docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
    sudo docker build -t velocity:${VERSION} .
    sudo docker tag velocity:${VERSION} mythoscode/velocity:${VERSION}
    sudo docker push mythoscode/velocity:${VERSION}
    sudo docker image rm velocity:${VERSION} mythoscode/velocity:${VERSION}
    exit 0
else
    echo "failed to download the velocity from $VELOCITY_JAR_URL"
    exit 1
fi
