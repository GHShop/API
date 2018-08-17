FROM amberframework/amber:v0.8.0

WORKDIR /app

COPY . /app

RUN shards build amber

RUN rm -rf /app/node_modules

CMD bin/amber watch
