# Use your favorite image
FROM alpine:latest
ARG S6_OVERLAY_VERSION=3.1.3.0
ARG ARCH=aarch64

# RUN apt-get update && apt-get install -y nginx xz-utils

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-${ARCH}.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz && \
    tar -C / -Jxpf /tmp/s6-overlay-${ARCH}.tar.xz

RUN apk add --update nginx shadow bash tzdata && \
    rm -rf /var/cache/apk/*

COPY --chown=root:root root /

VOLUME /config

EXPOSE 80 443
ENTRYPOINT ["/init"]