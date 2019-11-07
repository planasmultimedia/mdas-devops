#!/bin/bash
set -e


# cleanup
cleanup(){
    docker rm -f myvotingapp
    docker rm -f myredis
}

# build 
build(){   
    docker build \
    -f src/votingapp/Dockerfile \
    -t marcplanas/votingapp ./src/votingapp 

    docker run \
    --name myredis \
    --network votingapp \
    -d redis
    
    echo "Before docker run"

    docker run \
    --name myvotingapp \
    -p 8080:80 \
    --network votingapp \
    -e REDIS="myredis:6379" \
    -d marcplanas/votingapp
}

docker network create votingapp || true

#Si no enucentra nada que limpiar igualmente queremos que siga, por eso el "true"
cleanup || true
echo "BUILD STARTING"
build
echo "BUILD FINNISHED"

#test#    -f marcplanas/votingapp-test \

docker build \
    -t marcplanas/votingapp-test \
    ./test

echo "Before Run TESTS"

docker run -\
-rm -e VOTINGAPP_HOST="myvotingapp" \
--network votingapp \
marcplanas/votingapp-test 



#delivery
docker push marcplanas/votingapp