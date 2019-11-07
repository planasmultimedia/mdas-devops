########### BUILD ############
FROM golang AS builder

#Cada run es una layer nueva,utilizamos dos layers distintas porque las dependencias varian mucho menos
#DEPENDENCIAS
RUN go get github.com/gorilla/websocket && \
    go get github.com/labstack/echo && \
    go get github.com/go-redis/redis

COPY . .

#BUILD
RUN  go build -o /build/votingapp && \
    cp -r ui /build


################ RUNTIME ###################
FROM ubuntu:18.04

WORKDIR /app
COPY --from=builder build .

ENTRYPOINT [ "./votingapp" ]