#!/bin/bash

if [[ -z $1 ]]; then
  echo "You must enter a tag as the first argument to this script."
  exit -1
fi
tag=$1

# Build the image itself and push it to GitHub.
docker build -t ghcr.io/csu-cs-melange/alpha-language-image:$tag . --no-cache
docker push ghcr.io/csu-cs-melange/alpha-language-image:$tag

# Tag the image as being the latest and push that to GitHub also.
docker tag ghcr.io/csu-cs-melange/alpha-language-image:$tag tag ghcr.io/csu-cs-melange/alpha-language-image:latest
docker push ghcr.io/csu-cs-melange/alpha-language-image:latest
