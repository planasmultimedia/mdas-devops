FROM golang:alpine AS builder

COPY . .

RUN apk update && apk add --no-cache git && \
    rm -rf /var/cache/apk/*

WORKDIR src/votingapp  

RUN go get github.com/labstack/echo && \
    go get github.com/gorilla/websocket && \
    go get github.com/go-redis/redis


RUN go build -o /build/votingapp && \
    cp -r ui /build

######## RUNTIME #########
FROM alpine

WORKDIR /app

COPY --from=builder /build .

ENTRYPOINT [ "./votingapp" ]
