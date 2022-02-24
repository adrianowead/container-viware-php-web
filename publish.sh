#!/bin/bash

# ajustar o workdir
cd "$(dirname "$0")"

export DOCKR_IMG_NAME=viware-base-php
export DOCKR_HUB_REPO=adrianowead

# docker build
docker build -t "$DOCKR_IMG_NAME" --file=./Dockerfile .

# definir tag
export DOCKR_IMG_NAME_TAGGED="$DOCKR_IMG_NAME:latest"
export DOCKR_IMG_URI="$DOCKR_HUB_REPO/$DOCKR_IMG_NAME_TAGGED"

docker tag "$DOCKR_IMG_NAME_TAGGED" "$DOCKR_IMG_URI"

# enviar para HUB
docker push "$DOCKR_IMG_URI"
