# dev-containers

![DOCKERIZED SERVICES!](./magic.png)

## Bunch of bla bla (=> jump to [Usage](#usage))

This repository contains some docker-compose files created to make developer lives easier. The goal is to have ready to run services without requiring any kind of additional user configuration. In essence, it should eliminate the following timewasters:

- Looking up how to setup usernames/passwords
- Looking up which directories need to be bound to volumes to persist the data
- Trying to figure out how to make a docker-compose file WSL compatible
- Allowing a user to easily switch between different versions of the same service
- Having to remember credentials
- Worrying about some service cluttering your file system
- Having to deal with OS Services to shut down a database

While these compose files don't cover every use case they're a good starting point. Note that the compose files and configurations are created on demand (i.e. whenever I need something) and that they are adjusted to my own needs.

## Usage

1. You need [Docker](https://docker.com). If you're not on Windows or MacOS you also have to install [Docker Compose](https://docs.docker.com/compose/install/)
2. Enter the directory of the desired service/version and run `docker-compose up -d`.

## List of Containers

| Image                                | Port                                                                  | Username    | Password    |
| ------------------------------------ | --------------------------------------------------------------------- | ----------- | ----------- |
| CockpitCMS                           | 7320                                                                  | -           | -           |
| Elasticsearch 7.10.2 (\*)            | 9200 (Elasticsearch)<br />5601 (Kibana)<br />3002 (Enterprise Search) | elastic     | elastic     |
| MariaDB 10.1                         | 3306                                                                  | devel       | devel       |
| MariaDB 10.5.8                       | 3306                                                                  | devel       | devel       |
| MariaDB 10.5.9                       | 3306                                                                  | devel       | devel       |
| MariaDB (Latest)                     | 3306                                                                  | devel       | devel       |
| Minio (RELEASE.2021-06-17T00-10-46Z) | 9000 (old console)                                                    | minio_devel | minio_devel |
| Minio (Latest)                       | 9000<br />9001 (new console)                                          | minio_devel | minio_devel |
| MongoDB 4.4                          | 27017                                                                 | root        | root        |
| MongoDB (Latest)                     | 27017                                                                 | root        | root        |
| MySQL 5.7                            | 3306                                                                  | devel       | devel       |
| MySQL (Latest)                       | 3306                                                                  | devel       | devel       |
| Postgres (Latest)                    | 5432                                                                  | devel       | devel       |
| RabbitMQ (Latest)                    | 15672                                                                 | devel       | devel       |
| Redis (Latest)                       | 6379                                                                  | -           | -           |
| SonarScanner 4.4.0.2170              | -                                                                     | -           | -           |
| Traccar 4.10                         | 8082                                                                  | -           | -           |

(\*) _You might have to change the [max_map_count](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#docker-prod-prerequisites)_
