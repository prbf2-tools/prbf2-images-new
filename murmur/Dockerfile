FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y --no-install-recommends \
    python2 \
    wget \
    unzip \
    software-properties-common \
    gpg-agent ;

RUN add-apt-repository ppa:ubuntuhandbook1/ppa
RUN apt update
RUN apt install -y --no-install-recommends \
        libqt4-dbus \
        libqt4-sql \
        libqt4-sql-sqlite \
        libqt4-network ;

RUN useradd -d /murmur -ms /bin/bash murmur

COPY app/mods/pr/bin/PRMurmur /murmur

WORKDIR /tmp

# Install missing dependencies
RUN wget --no-check-certificate https://github.com/ClundXIII/pr-mumble-fix/archive/refs/heads/master.zip -O mumble_fix.zip
RUN unzip mumble_fix.zip
RUN dpkg -i pr-mumble-fix-master/ice34-slice_3.4.2-8.2_all.deb

# prmurmurd depends on libcrypto.so.1.0.0 from libssl1.0.0 
RUN wget http://snapshot.debian.org/archive/debian/20150709T214436Z/pool/main/o/openssl/libssl1.0.0_1.0.2d-1_amd64.deb
RUN dpkg -i libssl1.0.0_1.0.2d-1_amd64.deb

# Alias python2 to python
RUN ln -s /usr/bin/python2 /usr/bin/python

WORKDIR /murmur

RUN cp -r /tmp/pr-mumble-fix-master/python .
RUN cp -r /tmp/pr-mumble-fix-master/libs .

COPY murmur/setup.sh .
COPY murmur/entrypoint.sh .

RUN chmod +x setup.sh; \
    chmod +x entrypoint.sh; \
    chmod +x initialsetup.sh; \
    chmod +x createchannel.sh; \
    chmod +x prmurmurd.x64;

RUN chown -R murmur:murmur /murmur

EXPOSE 64740/tcp
EXPOSE 64740/udp

ENV LD_LIBRARY_PATH="/murmur/libs"
ENV PYTHONPATH="/murmur/python/Ice/"

ENV CHANNEL_ID="main0"
ENV SERVER_NAME="PR Server"
ENV GAMESERVER_IP="127.0.0.1"
# ENV MURMUR_SU_PASS="supersecretpassword"

USER murmur

ENTRYPOINT ["./entrypoint.sh"]
