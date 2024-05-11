FROM ghcr.io/ublue-os/bluefin-cli:testing

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="torgny@bjers.org"

COPY ./extra-packages /
COPY ./files /

# Update image, Install Packages
RUN apk update && \
    apk upgrade && \
    grep -v '^#' /extra-packages | xargs apk add && \
    rm /extra-packages
