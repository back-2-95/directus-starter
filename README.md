# Directus Starter

Quick starter repo for setting up [Directus](https://directus.io/) based data platform.

It's a headless CMS around database with REST and GraphQL APIs.

## Requirements

- Stonehenge

## Setup

```
make up
```

## Import directus.sql

```
make restore
```

Now open https://directus.docker.so and login with `admin@example.com:password`

## API

`https://directus.docker.so/collections/`

## Backups

Backup local database:

```
make backup
```

Restore database:

```
make restore
```
