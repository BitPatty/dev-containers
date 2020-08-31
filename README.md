# dev-containers

A collection of docker-compose files for local development compatible with the WSL2 docker engine.

## Usage

Enter the directory of the desired service and run `docker-compose up -d`. If you don't have `docker-comopose` installed read the [instructions in the docker docs](https://docs.docker.com/compose/install/) on how to install it.

## List of Images

| Image                   | Port  | Username    | Password    |
| ----------------------- | ----- | ----------- | ----------- |
| CockpitCMS              | 7320  | -           | -           |
| MariaDB 10.1            | 3306  | devel       | devel       |
| MariaDB (Latest)        | 3306  | devel       | devel       |
| Minio (Latest)          | 9000  | minio_devel | minio_devel |
| MongoDB (Latest)        | 27017 | root        | root        |
| MySQL 5.7               | 3306  | devel       | devel       |
| MySQL (Latest)          | 3306  | devel       | devel       |
| Postgres (Latest)       | 5432  | postgres    | root        |
| RabbitMQ (Latest)       | 15672 | devel       | devel       |
| SonarScanner 4.4.0.2170 | -     | -           | -           |
| Traccar 4.10            | 8082  | -           | -           |
