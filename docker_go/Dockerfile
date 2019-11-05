#A partir de que imagen se crea
FROM ubuntu:18.04
WORKDIR /app
COPY build .
#cada RUN es una layer mas, cada RUN hace un commits
#RUN apt-get update && apt-get install curl -y && rm -rf /var/lib/apt/lists/*

#Al hacer el run se espera un argumento para este "comando"
ENTRYPOINT [ "./votingapp" ]