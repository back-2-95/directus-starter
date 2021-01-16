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
$ docker exec -t directus-database pg_dumpall -c -U directus > dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql
```

Restore database:

```
$ cat your_dump.sql | docker exec -i directus-database psql -U directus
```
