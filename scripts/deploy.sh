#!/bin/bash

set -e

DEVTRON_URL=${DEVTRON_URL}
DEVTRON_API_TOKEN=${DEVTRON_API_TOKEN}
IMAGE=${IMAGE}
ID=${ID}
COMMIT_HASH=${COMMIT_HASH}
MESSAGE=${MESSAGE}
AUTHOR_NAME=${AUTHOR_NAME}
COMMIT_TIME=${COMMIT_TIME}

if [ -z "$COMMIT_HASH" ]; then
  COMMIT_HASH=""
fi

if [ -z "$MESSAGE" ]; then
  MESSAGE=""
fi

if [ -z "$AUTHOR_NAME" ]; then
  AUTHOR_NAME=""
fi

if [ -z "$COMMIT_TIME" ]; then
  COMMIT_TIME=""
fi

jsonData=$(cat <<EOF
{
  "dockerImage": "$IMAGE",
  "ciProjectDetails": [
    {
      "commitHash": "$COMMIT_HASH",
      "message": "$MESSAGE",
      "author": "$AUTHOR_NAME",
      "commitTime": "$COMMIT_TIME"
    }
  ]
}
EOF
)

curl --location --request POST \
  "https://${DEVTRON_URL}/orchestrator/webhook/ext-ci/${ID}" \
  --header 'Content-Type: application/json' \
  --header "api-token: ${DEVTRON_API_TOKEN}" \
  --data-raw "${jsonData}"