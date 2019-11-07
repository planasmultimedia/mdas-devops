#!/bin/bash
dependences (){
    go get github.com/gorilla/websocket
    go get github.com/labstack/echo
    go get github.com/go-redis/redis
}


#cleanup ,  si falla devuelve "true" ya que puede fallar
clean(){
    rm -rf build || true 
    ps aux | grep votingapp | awk {'print $1'} | head -l | xargs kill -9 
}

#build  
build(){
    mkdir build
    if go build -o ./build ./src/votingapp ; then
        cp -r ./src/votingapp/ui ./build
    else
        exit 1
    fi

    #ejecutar programa para hacer test
    pushd build
    #docker run --name myvotingapp -v /$(pwd)/build:/app -w //app -p 8080:80 ubuntu ./votingapp	    
    docker build -f votingapp_docker/Dockerfile -t marcplanas/votingapp .
    docker run --name votingapp -p 8080:80 -d marcplanas/votingapp
    popd
}



#test
test (){
    curl http://localhost/vote \
        --request POST \
        --data '{"topics": ["dev", "ops"]}' \
        --header "Content-Type: application/json"


    curl http://localhost/vote \
        --request PUT \
        --data '{"topic": "dev"}' \
        --header "Content-Type: application/json"


    winner=$(curl http://localhost/vote \
        --request DELETE \
        --header "Content-Type: application/json" | jq -r '.winner') 

    expectedWinner="dev"

    if [ "$expectedWinner" == "$winner" ]; then
        echo 'TEST PASSED'
        return 0
    else
        echo 'TEST FAILED'
        return 1
    fi

}

dependences
#clean
#GOOS esuna variable global que dice para que distribucion compila GO
#GOOS=linux build
test


