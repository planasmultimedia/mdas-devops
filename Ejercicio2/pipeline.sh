#!/bin/bash
set -e

docker network create alpine_votingapp || true

#cleanup
docker rm -f myvotingapp_alpine || true

#build
docker build \
    -t marcplanas/alpine_votingapp \
    ./

docker run \
    --name myvotingapp_alpine \
    --network alpine_votingapp \
    -p 8080:80 \
    -d marcplanas/alpine_votingapp

echo Starting Tests...
# test
docker build \
    -t marcplanas/votingapp_alpine-test \
    ./test


docker run \
    --rm -e VOTINGAPP_HOST="myvotingapp" \
    --network alpine_votingapp \
    marcplanas/votingapp_alpine-test

docker push marcplanas/alpine_votingapp