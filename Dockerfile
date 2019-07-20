FROM alpine:latest
LABEL maintainer="imTHAI <imTHAI@leet.la>"
LABEL description="Compiling & running latest version of pixelserv-tls under Alpine"

ENV server pixelserv-tls

RUN     apk update \
        && apk upgrade \
        && apk add --no-cache --virtual .build-deps git easy-rsa autoconf build-base openssl automake linux-headers \
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
        # Generate the certificates:
        && /usr/share/easy-rsa/easyrsa init-pki \
        && yes Pixelserv-tls | /usr/share/easy-rsa/easyrsa build-ca nopass \
        && mv /var/cache/pixelserv/pki/private/ca.key /var/cache/pixelserv/pki/ca.crt . \
        && chown -R nobody /var/cache/pixelserv \
        # Cleaning:
        && rm -rf /var/cache/pixelserv/pki /var/cache/apk/* \
        && apk del .build-deps

VOLUME  /var/cache/pixelserv

EXPOSE 443/tcp 80/tcp

ENTRYPOINT ["pixelserv-tls","-f"]
CMD ["-u","root"]
