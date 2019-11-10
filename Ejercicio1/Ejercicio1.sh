#!/bin/bash
set -e

# install deps
deps(){
    go get github.com/gorilla/websocket
    go get github.com/labstack/echo

    pip install requests
    pip install retry
}

# cleanup
cleanup(){
    pkill votingapp || ps aux | grep votingapp | awk {'print $1'} | head -1 | xargs kill -9
    rm -rf build || true
}

# build 
build(){
    mkdir build
    go build -o ./build ./src/votingapp 
    cp -r ./src/votingapp/ui ./build

    pushd build
    ./votingapp &
    popd
}

test(){
    python python_tests.py 
}


deps
cleanup
build
test