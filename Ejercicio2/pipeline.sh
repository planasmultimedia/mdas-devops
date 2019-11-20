#!/bin/bash
set -e

docker network create alpine_votingapp || true

#cleanup
docker rm -f test2 || true

#build
docker build \
    -t tests2 \
    ./

docker run \
    --name test2 \
    --network alpine_votingapp \
    -p 8080:80 \
    -d tests2

echo Starting Tests...
# test
docker build \
    -t marcplanas/votingapp_test \
    ./test

docker run \
    --rm -e VOTINGAPP_HOST="test2" \
    --network alpine_votingapp \
    marcplanas/votingapp_test

docker push marcplanas/votingapp_alpine-test