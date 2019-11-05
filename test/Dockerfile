#A partir de que imagen se crea
FROM ubuntu:18.04

#cada RUN es una layer mas, cada RUN hace un commits
RUN apt-get update && apt-get install -y  \
    curl \
    jq \
    && rm -rf /var/lib/apt/lists/*

COPY test.sh .

RUN chmod +x test.sh

ENTRYPOINT [ "./test.sh" ]