#!/bin/sh

docker run -it --rm -p 7474:7474 -p 7687:7687 --env=NEO4J_AUTH=none peptides/db

# docker run -it --rm -p 7474:7474 -p 7687:7687 --env=NEO4J_AUTH=none -v $PWD/data:/data -v $PWD/logs:/logs neo4j:3.5
