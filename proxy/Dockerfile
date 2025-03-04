FROM ubuntu:22.04 AS download
ARG PROXY_VER="1.0.1.0"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y --no-install-recommends \
  wget \
  unzip

WORKDIR /proxy

RUN wget --no-check-certificate https://gitlab.com/realitymod/public/prserverproxy/-/archive/$PROXY_VER/prserverproxy-$PROXY_VER.zip
RUN unzip -j prserverproxy-$PROXY_VER.zip

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y --no-install-recommends \
  python3 \
  python3-aiohttp \
  python3-certifi

RUN useradd -u 16567 -d /proxy -ms /bin/bash prproxy

USER prproxy
WORKDIR /proxy

COPY --from=download --chown=prproxy:prproxy /proxy /proxy

ENTRYPOINT ["python3", "main.py"]
