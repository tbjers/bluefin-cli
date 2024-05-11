FROM ghcr.io/ublue-os/bluefin-cli:testing

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="torgny@bjers.org"

COPY files /

COPY extra-packages /

# Update image, install packages, and move /home/linuxbrew
RUN apk update && \
    apk upgrade && \
    grep -v '^#' /extra-packages | xargs apk add && \
    mv /home/linuxbrew /home/homebrew && \
    rm /extra-packages

# Use and configure bash, retreive bash-prexec
RUN curl https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh -o /tmp/bash-prexec && \
    mkdir -p /usr/share/ && \
    cp /tmp/bash-prexec /usr/share/bash-prexec && \
    rm -rf /tmp/*
