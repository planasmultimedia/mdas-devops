#!/bin/bash
set -e

#clean
docker-compose rm -f && \

#build
#docker-compose build
docker-compose up --build -d && \
#-d es detach para que siga
#test
docker-compose run --rm mytest && \
#delivery
docker-compose push && \
echo "GREEN" || echo "RED"