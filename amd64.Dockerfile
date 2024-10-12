FROM alpine:3.17 AS build

WORKDIR /tmp/plugins
RUN wget https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/3.5.0.15/apoc-3.5.0.15-all.jar

WORKDIR /tmp/database
COPY starPep.db.zip ./

RUN unzip starPep.db.zip

FROM neo4j:3.5

RUN apt-get update && apt-get install -y net-tools

COPY --from=build --chown=neo4j:neo4j /tmp/database/starPep.db /data/databases/graph.db
COPY --from=build --chown=neo4j:neo4j /tmp/plugins /plugins
COPY neo4j.conf /var/lib/neo4j/conf/neo4j.conf

HEALTHCHECK --interval=15s --timeout=5s --start-period=5s --retries=3 CMD netstat -na | grep 7687.*LISTEN || exit 1
