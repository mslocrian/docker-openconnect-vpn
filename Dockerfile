FROM ubuntu:19.04
RUN apt-get update && apt-get -y install iputils-ping iptables net-tools \
    openconnect tcpdump
ADD entrypoint.sh /entrypoint.sh
HEALTHCHECK  --interval=10s --timeout=10s --start-period=10s \
  CMD /sbin/ifconfig tun0
CMD ["/entrypoint.sh"]
