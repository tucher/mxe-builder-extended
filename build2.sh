# TAG=gcc13-qt5-qt6-2
# ACCOUNT=tucher
# IMAGE_NAME=mxe-builder-extended

#    docker buildx build --platform linux/arm64 --push -t $ACCOUNT/$IMAGE_NAME:$TAG-arm64 . \
# && docker buildx build --platform linux/amd64 --push -t $ACCOUNT/$IMAGE_NAME:$TAG-amd64 . \
# \
# && docker manifest create $ACCOUNT/$IMAGE_NAME:$TAG $ACCOUNT/$IMAGE_NAME:$TAG-amd64 $ACCOUNT/$IMAGE_NAME:$TAG-arm64 \
# && docker manifest annotate $ACCOUNT/$IMAGE_NAME:$TAG $ACCOUNT/$IMAGE_NAME:$TAG-amd64 --os linux --arch amd64 \
# && docker manifest annotate $ACCOUNT/$IMAGE_NAME:$TAG $ACCOUNT/$IMAGE_NAME:$TAG-arm64 --os linux --arch arm64 \
# \
# && docker manifest push $ACCOUNT/$IMAGE_NAME:$TAG

TAG=gcc13-qt5-qt6-2
ACCOUNT=tucher
IMAGE_NAME=mxe-builder-extended

   docker buildx build --platform linux/arm64 --push -t $ACCOUNT/$IMAGE_NAME:$TAG-arm64 . \
\
&& docker manifest create $ACCOUNT/$IMAGE_NAME:$TAG  $ACCOUNT/$IMAGE_NAME:$TAG-arm64 \
&& docker manifest annotate $ACCOUNT/$IMAGE_NAME:$TAG $ACCOUNT/$IMAGE_NAME:$TAG-arm64 --os linux --arch arm64 \
\
&& docker manifest push $ACCOUNT/$IMAGE_NAME:$TAG
 