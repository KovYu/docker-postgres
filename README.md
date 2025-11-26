<p align="center">
    <h1 align="center">PostgreSQL Running in Docker</h1>
    <br>
</p>

## Requirements

Docker with Docker Compose plugin

If you do not have [Docker](https://www.docker.com/), you may install it by following the instructions
at [docs.docker.com](https://docs.docker.com/engine/install/).

## Installation

Copy environment configuration templates to .env files:
```
cp ./.env.dist ./.env
```
Change environment variable values if necessary.

You can install this Application using the following command:

```
make build
```

Run Application by following command:

```
make up
```

See other available commands in the ./Makefile file.
