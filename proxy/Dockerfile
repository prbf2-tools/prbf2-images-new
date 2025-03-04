FROM alpine:3.21 AS download
ARG PROXY_VER="master"

RUN apk add \
  wget \
  unzip

WORKDIR /proxy

RUN wget --no-check-certificate https://gitlab.com/realitymod/public/prserverproxy/-/archive/$PROXY_VER/prserverproxy-$PROXY_VER.zip
RUN unzip -j prserverproxy-$PROXY_VER.zip

FROM python:3-alpine3.21

ENV DEBIAN_FRONTEND=noninteractive

RUN pip3 install \
  aiohttp \
  certifi

RUN adduser -u 16567 -h /proxy -s /bin/bash -D prproxy

USER prproxy
WORKDIR /proxy

COPY --from=download --chown=prproxy:prproxy /proxy /proxy

ENTRYPOINT ["python3", "main.py"]
