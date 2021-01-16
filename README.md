# Directus Starter

## Requirements

- Stonehenge

## Setup

```
$ make up
```

## Import directus.sql

```
$ make restore
```

Now open https://directus.docker.sh and login with `admin@example.com:password`

## API

`https://directus.docker.sh/collections/`

## Backups

Backup local database:

```
$ make backup
```

Restore database:

```
$ make restore
```
