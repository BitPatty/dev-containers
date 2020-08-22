
FROM alpine:3.12.0

ARG SONAR_SCANNER_CLI_VERSION="4.4.0.2170"

# Prepare workspace
RUN apk add --no-cache curl grep sed unzip bash openjdk8
WORKDIR /src
COPY . .

# Install the sonar scanner cli
# Based off https://github.com/newtmitch/docker-sonar-scanner/blob/master/Dockerfile.sonarscanner-3.2.0-alpine
WORKDIR /tmp
RUN curl --insecure -o ./sonarscanner.zip -L https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_CLI_VERSION}-linux.zip
RUN unzip ./sonarscanner.zip
RUN rm ./sonarscanner.zip
RUN mv ./sonar-scanner-${SONAR_SCANNER_CLI_VERSION}-linux /usr/lib/sonar-scanner
RUN ln -s /usr/lib/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner
ENV SONAR_RUNNER_HOME=/usr/lib/sonar-scanner
RUN sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' /usr/lib/sonar-scanner/bin/sonar-scanner

WORKDIR /src

ENTRYPOINT ["sonar-scanner"] 