FROM alpine:latest
LABEL maintainer="imTHAI <imTHAI@leet.la>"
LABEL description="Compiling & running latest version of pixelserv-tls under Alpine"

ENV server pixelserv-tls

RUN     apk update \
        && apk upgrade \
        && apk add --no-cache --virtual .build-deps git autoconf build-base openssl automake linux-headers \
        && apk add --no-cache openssl-dev \
        && mkdir -p /var/cache/pixelserv \
        && cd /var/cache/pixelserv \
        && git clone https://github.com/kvic-z/${server}.git . \
        && autoreconf -i \
        && ./configure \
        && make \
        && find . \! -name "$server" -delete \
        && chmod +x $server \
        && mv $server /usr/sbin \
        && apk del .build-deps

VOLUME  /var/cache/pixelserv

COPY root/ /

EXPOSE 443/tcp 80/tcp

RUN chmod +x /etc/init.d/docker-entrypoint.sh
ENTRYPOINT ["/etc/init.d/docker-entrypoint.sh"]
