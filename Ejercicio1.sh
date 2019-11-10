#!/bin/bash
deps(){
    go get github.com/gorilla/websocket
    go get github.com/labstack/echo
    go get github.com/go-redis/redis

}

cleanup(){
    rm -rf build || true
    pkill votingapp || ps aux | grep votingapp | awk {'print $2'} | head -1 | xargs kill -9
}

build(){
    mkdir build
    go build -o ./build ./src/votingapp 
    cp -r ./src/votingapp/ui ./build

    pushd build
    ./votingapp &
    popd
}

test() {
    votingurl='http://localhost:80/vote'
    curl --url  $votingurl \
        --request POST \
        --data '{"topics":["dev", "ops"]}' \
        --header "Content-Type: application/json" 

    curl --url $votingurl \
        --request PUT \
        --data '{"topic": "dev"}' \
        --header "Content-Type: application/json" 

    winner=$(curl --url $votingurl \
        --request DELETE \
        --header "Content-Type: application/json" | jq -r '.winner')

    echo "Winner IS "$winner

    expectedWinner="dev"

    if [ "$expectedWinner" == "$winner" ]; then
        echo 'TEST PASSED'
        return 0
    else
        echo 'TEST FAILED'
        return 1
    fi
}

deps
cleanup
build
test



