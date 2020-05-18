# Postgres DB

A setup for postgres db running with docker on port 5432.

## Running an initialization SQL or sh script

You can initialize this database by creating some files in a folder under your
docker-compose.yml file called pg. The docker initialization scripts will run
any .sql file or any .sh file it finds in there during startup. So you can
create database users or create table schema by placing files in those
directories. Also see import below.

The default username will be postgres and the password for that user is defined
in the environment variable POSTGRESPASSWORD which is defined in the env file.

## Connect into pg prompt in container

```
docker exec -it postgres-container psql -U postgres
```

## Import export from postgres container

```
# create dump
docker exec -t your-db-container pg_dumpall -c -U postgres > dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql
# import dump
cat your_dump.sql | docker exec -i your-db-container psql -U postgres
```
