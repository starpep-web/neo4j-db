FROM alpine:3.17 AS build

WORKDIR /tmp
COPY starPep.db.zip ./

RUN unzip starPep.db.zip

FROM neo4j:3.5

RUN apt-get update && apt-get install -y lsof

COPY --from=build /tmp/starPep.db /data/databases/graph.db

COPY neo4j.conf /var/lib/neo4j/conf/neo4j.conf

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 CMD "lsof -i:7687 | grep LISTEN || exit 1"

ENTRYPOINT ["tini", "-g", "--", "/startup/docker-entrypoint.sh"]
CMD ["neo4j"]
