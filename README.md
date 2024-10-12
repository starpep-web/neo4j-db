# Peptide Neo4j Graph Database Docker Image

This repository contains a Dockerfile to build the Neo4j database with the Peptide information already preloaded in.

## Requirements

In order to make use of this Docker image, [Docker](https://www.docker.com/) should be installed in your machine.

## Using the Production Pre-built Image

A prebuilt image is available on a private registry. For this, you will need an account from the [private registry](https://code.moonstar-x.dev/webpep).

Once you have an account in that registry, login with docker:

```text
docker login code.moonstar-x.dev
```

And finally, create a container with the prebuilt image:

```text
docker run -it --rm -p 7474:7474 -p 7687:7687 --env=NEO4J_AUTH=none code.moonstar-x.dev/webpep/neo4j-db:latest
```

Or, using the original tag without any modifications:

```text
docker run -it --rm -p 7474:7474 -p 7687:7687 --env=NEO4J_AUTH=none code.moonstar-x.dev/webpep/neo4j-db:original
```

## Building

To build this image, run the following command from the folder of this repository.

For the `linux/amd64` image:

```text
docker build --no-cache -t test/neo4j-db -f amd64.Dockerfile .
```

For the `linux/arm64` image:

```text
docker build --no-cache -t test/neo4j-db -f arm64.Dockerfile .
```

> TODO: Replace `test/neo4j-db` with the name of the image to use.

## Testing

You can start the database locally with:

```text
docker run -it --name local-neo4j --rm -p 7474:7474 -p 7687:7687 --env=NEO4J_AUTH=none test/neo4j-db
```

> TODO: Replace `test/neo4j-db` with the name of the image to use.

## Modifying

Before you decide to modify the database, **make sure** that you have deleted the `starPep.db` folder and `starPep.db.zip` file in your local directory.

In order to modify the database, a local database instance should be started up with the following command:

```text
docker run -it --name local-neo4j --rm -p 7474:7474 -p 7687:7687 -v $(pwd)/starPep.db:/output -v $(pwd)/neo4j.editable.conf:/conf/neo4j.conf --env=NEO4J_AUTH=none test/neo4j-db /bin/bash
```

1. First, run the `neo4j start` command inside the container.
2. Modify the database.
3. Stop the database with the `neo4j stop`command inside the container.

Since the database is constructed from a zip file with the database, any modifications should be exported as a zip.

In order to do this, with the database's docker container up, run the following command:

```text
docker exec -it local-neo4j cp -r /data/databases/graph.db/. /output && zip starPep.db.zip -r starPep.db/*
```

You can now close the original container with the `exit` command.

You now have a new `starPep.db.zip` file with the updated database, which should be committed to this repo.

You can then rebuild the image:

```text
docker build --no-cache -t test/neo4j-db .
```

And use it as normal.

## Notes

Currently, the image is pre-built with the database content. It is also set as **Read Only**.

You can change this by editing the `neo4j.conf` file and replace the line:

```text
dbms.read_only=true
```

to:

```text
dbms.read_only=false
```
