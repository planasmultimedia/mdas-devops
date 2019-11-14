FROM alpine:3.10

RUN apk update && \
    apk add bash && \
    apk add --no-cache python3

COPY tests.py .

ENTRYPOINT ["py", "test.py"]

