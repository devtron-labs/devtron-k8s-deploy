#!/bin/bash

set -e

# Use GitHub context variables if inputs are not provided
COMMIT_HASH=${COMMIT_HASH:-$GITHUB_SHA}
MESSAGE=${MESSAGE:-$GITHUB_MESSAGE}
AUTHOR_NAME=${AUTHOR_NAME:-$GITHUB_AUTHOR}
COMMIT_TIME=${COMMIT_TIME:-$GITHUB_COMMIT_TIME}

DEVTRON_URL=${DEVTRON_URL}
DEVTRON_API_TOKEN=${DEVTRON_API_TOKEN}
IMAGE=${IMAGE}
ID=${ID}

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