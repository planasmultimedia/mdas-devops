FROM golang AS builder

RUN go get github.com/gorilla/websocket && \
    go get github.com/labstack/echo

COPY . .

WORKDIR src/votingapp

RUN go build -o /build/votingapp && \
    cp -r ui /build

######## RUNTIME #########
FROM alpine:3.10

RUN apk update && \
    apk add bash && \
    apk add --no-cache python3

COPY --from=builder /build .


ENTRYPOINT [ "./votingapp" ]
