FROM amberframework/amber:v0.7.0

WORKDIR /app

COPY shard.* /app/
RUN crystal deps

COPY . /app

CMD amber watch
