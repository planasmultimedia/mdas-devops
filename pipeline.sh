#!/bin/bash

go get github.com/gorilla/websocket
go get github.com/labstack/echo

#cleanup
rm -rf build

mkdir build

if go build -o ./build ./src/votingapp ; then
    cp -r ./src/votingapp/ui ./build
else
    exit 1
fi