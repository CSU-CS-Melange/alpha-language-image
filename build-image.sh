#!/bin/bash

if [[ -z $1 ]]; then
  tag=latest
else
  tag=$1
fi

docker build -t ghcr.io/csu-cs-melange/alpha-language-image:$tag .
