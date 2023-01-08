FROM alpine:3.17 AS build

WORKDIR /tmp
COPY starPep.db.zip ./

RUN unzip starPep.db.zip

FROM neo4j:3.5

RUN apt-get update && apt-get install -y net-tools

COPY --from=build --chown=neo4j:neo4j /tmp/starPep.db /data/databases/graph.db
COPY neo4j.conf /var/lib/neo4j/conf/neo4j.conf

HEALTHCHECK --interval=15s --timeout=5s --start-period=5s --retries=3 CMD netstat -na | grep 7687.*LISTEN || exit 1
