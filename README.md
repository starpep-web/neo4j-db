# Peptide Neo4j Graph Database Docker Image

This repository contains a Dockerfile to build the Neo4j database with the Peptide information already preloaded in.

## Requirements

In order to make use of this Docker image, [Docker](https://www.docker.com/) should be installed in your machine.

## Using the Pre-built Image

A prebuilt image is available on a private registry. For this, you will need an account from the [private registry](https://registry.moonstar-x.dev/).

Once you have an account in that registry, login with docker:

```text
docker login registry-docker.moonstar-x.dev
```

And finally, create a container with the prebuilt image:

```text
docker run -it --rm -p 7474:7474 -p 7687:7687 --env=NEO4J_AUTH=none registry-docker.moonstar-x.dev/webpep/neo4j-db
```

## Building

To build this image, run the following command from the folder of this repository.

```text
docker build -t peptides/db .
```

> TODO: Replace `peptides/db` with the name of the image to use.

## Testing

You can start the database with:

```text
docker run -it --rm -p 7474:7474 -p 7687:7687 --env=NEO4J_AUTH=none peptides/db
```

> TODO: Replace `peptides/db` with the name of the image to use.

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
