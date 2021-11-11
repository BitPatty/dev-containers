FROM mcr.microsoft.com/mssql/server:2019-latest

USER root
RUN apt-get -q update && apt-get -qy install netcat

USER mssql
ARG SA_PASSWORD="Password123"
ENV SA_PASSWORD=${SA_PASSWORD}
ENV ACCEPT_EULA="Y"

RUN mkdir /tmp/docker-init
WORKDIR /tmp/docker-init

COPY --chown=mssql:root ./init.sh ./init.sh
COPY --chown=mssql:root ./wait-for.sh ./wait-for.sh
COPY --chown=mssql:root ./init.sql ./init.sql

RUN sh ./init.sh

WORKDIR /

RUN rm -rf /tmp/docker-init