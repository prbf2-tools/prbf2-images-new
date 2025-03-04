FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y --no-install-recommends \
  wget \
  libncurses5 \
  libpython2.7 \
  python2.7 \
  libicu-dev \
  ca-certificates

RUN useradd -u 16567 -d /pr -ms /bin/bash pr

WORKDIR /pr
COPY --chown=pr:pr app/ .

RUN wget https://files.realitymod.com/resources/PRServerUpdater_Linux_x64 -O mods/pr/bin/PRServerUpdater_Linux_x64

RUN chmod +x bin/amd-64/prbf2_l64ded.PRMSProxy
RUN chmod +x bin/amd-64/prbf2_l64ded
RUN chmod +x start_pr.sh
RUN chmod +x mods/pr/bin/PRServerUpdater_Linux_x64

RUN rm -r pb && cp -r pb_amd-64 pb
RUN ln -s /usr/bin/python2.7 /usr/bin/python

USER pr

# Install missing library
# RUN wget http://launchpadlibrarian.net/362321144/libcrypto1.0.0-udeb_1.0.2n-1ubuntu5_amd64.udeb
COPY assets/libcrypto1.0.0-udeb_1.0.2n-1ubuntu5_amd64.udeb .
RUN mkdir _tmp && dpkg -x libcrypto1.0.0-udeb_1.0.2n-1ubuntu5_amd64.udeb _tmp/
RUN cp _tmp/usr/lib/libcrypto.so.1.0.0 bin/amd-64/ && rm -r _tmp


# game port
EXPOSE 16567/udp
# stats port
EXPOSE 27900/udp
# gamespy
EXPOSE 29900/udp
# remote console
EXPOSE 4711/tcp
# prism
EXPOSE 4712/tcp


ENV LD_LIBRARY_PATH="/pr/bin/amd-64"

ENTRYPOINT ["./start_pr.sh"]
CMD ["+noStatusMonitor", "1", "+multi", "1", "+dedicated", "1"]
