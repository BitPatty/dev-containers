FROM ubuntu:bionic AS build-server
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update
RUN apt-get install -y \
  bash \
  curl \
  ruby \
  unzip \
  zip \
  git \
  makeself \
  openjdk-8-jdk
WORKDIR /src
RUN git clone --depth 1 --branch v4.10 --recursive https://github.com/traccar/traccar.git .
RUN bash gradlew assemble
WORKDIR /src/build
RUN unzip ./distributions/tracker-server.zip

FROM ubuntu:bionic AS build-web
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update
RUN apt-get install -y \
  bash \
  curl \
  unzip \
  zip \
  git \
  fontconfig \
  apt-transport-https \
  build-essential \
  ca-certificates \
  libssl-dev \
  wget
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
RUN bash -i -c 'nvm install 12.18.2'
ENV PATH="/root/.nvm/versions/node/v12.18.2/bin:${PATH}"
WORKDIR /src
RUN git clone --depth 1 --branch v4.10 https://github.com/traccar/traccar-web.git . 
WORKDIR /src/modern
RUN npm i
RUN npm run build

FROM openjdk:13-alpine3.9 AS final
COPY --from=build-server /src/build/tracker-server /app
COPY --from=build-server /src/setup/default.xml /app/conf/default.xml
COPY --from=build-server /src/setup/traccar.xml /app/conf/traccar.xml
COPY --from=build-server /src/schema /app/schema
COPY --from=build-web /src/modern/build /app/web
WORKDIR /app
RUN ls -als
RUN chmod +x ./bin/tracker-server
RUN mkdir logs
RUN touch logs/tracker-server.log

ENTRYPOINT [ "./bin/tracker-server", "/app/conf/traccar.xml" ]