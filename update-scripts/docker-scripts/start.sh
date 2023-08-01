#!/bin/bash

cd ../..
docker run -it --name local-neo4j-to-modify --rm -p 7474:7474 -p 7687:7687 -v $(pwd)/starPep.db:/output -v $(pwd)/neo4j.editable.conf:/conf/neo4j.conf --env=NEO4J_AUTH=none local/neo4j-db-modify /bin/bash
