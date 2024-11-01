# Neo4j StarPep Graph Database

This repository contains the code to build the Neo4j database's Docker Image.

Currently, the image is pre-built with the database content. It is also set as **Read Only**.

## Requirements

In order to develop for this repository you need:

* [Python 3.12](https://www.python.org) (but any `>3.12` should work fine)
* [Docker](https://www.docker.com/products/docker-desktop/)

## Development

First, clone this repository:

```bash
git clone https://github.com/starpep-web/neo4j-db
```

### Modifying

Before you decide to modify the database, **make sure** that you have deleted the `starPep.db` folder and `starPep.db.zip` file in your local directory.

In order to modify the database, a local database instance should be started up with the following command:

For `linux/amd64`:

```bash
docker run -it --name local-neo4j --rm -p 7474:7474 -p 7687:7687 -v $(pwd)/starPep.db:/output -v $(pwd)/neo4j.editable.conf:/conf/neo4j.conf --env=NEO4J_AUTH=none local-starpep/neo4j-db:latest /bin/bash
```

For `linux/arm64`:

```bash
docker run -it --name local-neo4j --rm -p 7474:7474 -p 7687:7687 -v $(pwd)/starPep.db:/output -v $(pwd)/neo4j.editable.conf:/conf/neo4j.conf --env=NEO4J_AUTH=none local-starpep/neo4j-db:latest /bin/bash
```

1. First, run the `neo4j start` command inside the container.
2. Modify the database.
3. Stop the database with the `neo4j stop`command inside the container.

Since the database is constructed from a zip file with the database, any modifications should be exported as a zip.

In order to do this, with the database's docker container up, run the following command on the host:

```bash
docker exec -it local-neo4j cp -r /data/databases/graph.db/. /output && zip starPep.db.zip -r starPep.db/*
```

You can now close the original container with the `exit` command.

You now have a new `starPep.db.zip` file with the updated database, which should be committed to this repo.

You can then rebuild the image:

For `linux/amd64`:

```bash
docker build  --no-cache -f amd64.Dockerfile -t local-starpep/neo4j-db:latest .
```

For `linux/arm64`:

```bash
docker build  --no-cache -f arm64.Dockerfile -t local-starpep/neo4j-db:latest-arm .
```

And use it as normal.

## Building

If you're developing this on your local machine, consider building the Docker image with the following command:

For `linux/amd64`:

```bash
docker build  --no-cache -f amd64.Dockerfile -t local-starpep/neo4j-db:latest .
```

For `linux/arm64`:

```bash
docker build  --no-cache -f arm64.Dockerfile -t local-starpep/neo4j-db:latest-arm .
```

You can create a new container to try it out with the following command:

For `linux/amd64`:

```bash
docker run -it --rm -p 7474:7474 -p 7687:7687 -e NEO4J_AUTH=none local-starpep/neo4j-db:latest
```

For `linux/arm64`:

```bash
docker run -it --rm -p 7474:7474 -p 7687:7687 -e NEO4J_AUTH=none local-starpep/neo4j-db:latest-arm
```

And done, the web manager should be reachable at `http://localhost:7474` and your database reachable at `bolt://localhost:7687`.

## Production

Consider checking this [docker-compose.yml](https://github.com/starpep-web/env-production/blob/main/docker-compose.yml) for an example on how to run this image in production.
