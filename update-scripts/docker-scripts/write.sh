#!/bin/bash

docker exec -it local-neo4j-to-modify cp -r /data/databases/graph.db/. /output && zip starPep.db.zip -r starPep.db/*
