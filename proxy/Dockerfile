FROM ubuntu:22.04
ARG PROXY_VER="1.0.1.0"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y --no-install-recommends \
  wget \
  unzip \
  python3 \
  python3-aiohttp \
  python3-certifi

WORKDIR /proxy

RUN wget --no-check-certificate https://gitlab.com/realitymod/public/prserverproxy/-/archive/$PROXY_VER/prserverproxy-$PROXY_VER.zip
RUN unzip -j prserverproxy-$PROXY_VER.zip

RUN useradd -d /proxy -ms /bin/bash proxy
RUN chown -R proxy:proxy /proxy

USER proxy

ENTRYPOINT ["python3", "main.py"]
