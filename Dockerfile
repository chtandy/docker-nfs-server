FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive
ENV TERM xterm
ADD data/conf/nfs-run.sh /usr/local/bin/nfs-run
ADD data/conf/nfs-server.conf /etc/supervisor/conf.d/

RUN apt-get update  \
  && apt-get install -y vim wget curl supervisor nfs-kernel-server \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN chmod +x /usr/local/bin/nfs-run \
  && mkdir /data \
  && chmod -R 775 /data

CMD ["/usr/bin/supervisord", "--nodaemon", "-c", "/etc/supervisor/supervisord.conf"]
