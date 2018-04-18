FROM amberframework/amber:v0.7.2

WORKDIR /app

COPY shard.* /app/
RUN crystal deps

COPY . /app

CMD amber watch
