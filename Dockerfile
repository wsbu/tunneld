FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive \
    TUNNELD_CERT_DIR=/etc/ssl/certs/tunneld

RUN apt-get update && apt-get install --yes --no-install-recommends \
    openssl \
  && rm --recursive --force /var/lib/apt/lists/*

ADD https://github.com/mmatczuk/go-http-tunnel/releases/download/2.1/tunnel_linux_amd64.tar.gz /usr/local/bin
RUN cd /usr/local/bin && tar -xf tunnel_linux_amd64.tar.gz ./tunneld && rm tunnel_linux_amd64.tar.gz

VOLUME "${TUNNELD_CERT_DIR}"

COPY start.sh /start.sh
ENTRYPOINT "/start.sh"
