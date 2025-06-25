#!/bin/bash

# Config
IMAGES=(
  "fat:Dockerfile.fat"
  "slim:Dockerfile.slim"
  "multistage:Dockerfile.multistage"
)
APP_NAME="dockslim-demo"
PUSHGATEWAY_URL="http://localhost:9091"
JOB_NAME="docker_image_build"

for entry in "${IMAGES[@]}"; do
  IFS=":" read -r TAG DOCKERFILE <<< "$entry"
  IMAGE_TAG="$APP_NAME:$TAG"

  echo "Building $IMAGE_TAG using $DOCKERFILE..."
  START=$(date +%s)
  docker build -f "$DOCKERFILE" -t "$IMAGE_TAG" .
  END=$(date +%s)
  BUILD_TIME=$((END-START))

  IMAGE_SIZE=$(docker image inspect "$IMAGE_TAG" --format='{{.Size}}')
  IMAGE_SIZE_MB=$(echo "scale=2; $IMAGE_SIZE/1024/1024" | bc)

  TIMESTAMP=$(date +%s)

  # Prepare Prometheus metrics
  METRICS=""
  METRICS+="docker_image_build_time_seconds{image=\"$IMAGE_TAG\"} $BUILD_TIME\n"
  METRICS+="docker_image_size_megabytes{image=\"$IMAGE_TAG\"} $IMAGE_SIZE_MB\n"

  # Push to Prometheus Pushgateway
  echo -e "$METRICS" | curl --data-binary @- "$PUSHGATEWAY_URL/metrics/job/$JOB_NAME/image/$TAG"

done
