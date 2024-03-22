#/bin/bash

BUILDER_NAME="multi-arch-builder"

if docker buildx ls | grep -q "$BUILDER_NAME"; then
  echo "Builder $BUILDER_NAME already exists."
else  
  docker buildx create --name "$BUILDER_NAME" --driver docker-container --use  
  echo "Builder $BUILDER_NAME created and activated."
fi

docker run -it --rm --privileged tonistiigi/binfmt --install all 

SP_VERSION=1 && docker buildx build --progress=plain --no-cache . -f kylin_v10.sys.Dockerfile --platform=linux/amd64,linux/arm64 -t kylin:v10-sp$SP_VERSION-amd64 --build-arg SP_VERSION=$SP_VERSION 2>&1 | tee kylin:v10-sp$SP_VERSION-build.log
# SP_VERSION=1 && docker buildx build --progress=plain --no-cache . -f kylin_v10.sys.Dockerfile --platform=linux/arm64 -t kylin:v10-sp$SP_VERSION-arm64 --build-arg SP_VERSION=$SP_VERSION 2>&1 | tee kylin:v10-sp$SP_VERSION-arm64-build.log
SP_VERSION=2 && docker buildx build --progress=plain --no-cache . -f kylin_v10.sys.Dockerfile --platform=linux/amd64,linux/arm64 -t kylin:v10-sp$SP_VERSION-amd64 --build-arg SP_VERSION=$SP_VERSION 2>&1 | tee kylin:v10-sp$SP_VERSION-build.log
# SP_VERSION=2 && docker buildx build --progress=plain --no-cache . -f kylin_v10.sys.Dockerfile --platform=linux/arm64 -t kylin:v10-sp$SP_VERSION-arm64 --build-arg SP_VERSION=$SP_VERSION 2>&1 | tee kylin:v10-sp$SP_VERSION-arm64-build.log
SP_VERSION=3 && docker buildx build --progress=plain --no-cache . -f kylin_v10.sys.Dockerfile --platform=linux/amd64,linux/arm64 -t kylin:v10-sp$SP_VERSION-amd64 --build-arg SP_VERSION=$SP_VERSION 2>&1 | tee kylin:v10-sp$SP_VERSION-build.log
#SP_VERSION=3 && docker buildx build --progress=plain --no-cache . -f kylin_v10.sys.Dockerfile --platform=linux/arm64 -t kylin:v10-sp$SP_VERSION-arm64 --build-arg SP_VERSION=$SP_VERSION 2>&1 | tee kylin:v10-sp$SP_VERSION-arm64-build.log
