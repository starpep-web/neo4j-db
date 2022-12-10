# Peptide Neo4j Graph Database Docker Image

This repository contains a Dockerfile to build the Neo4j database with the Peptide information already preloaded in.

## Requirements

In order to make use of this Docker image, [Docker](https://www.docker.com/) should be installed in your machine.

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

## Development Files

You can use the `build.sh` and `test.sh` to quickly build and test the image locally.
