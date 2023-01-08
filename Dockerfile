FROM alpine:3.17 AS build

WORKDIR /tmp
COPY starPep.db.zip ./

RUN unzip starPep.db.zip

FROM neo4j:3.5

COPY --from=build /tmp/starPep.db /data/databases/graph.db

COPY neo4j.conf /var/lib/neo4j/conf/neo4j.conf

EXPOSE 7687

ENTRYPOINT ["tini", "-g", "--", "/startup/docker-entrypoint.sh"]
CMD ["neo4j"]
