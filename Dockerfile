FROM debian:stable-slim
LABEL maintainer="Stegen Smith <stegen@owns.com>"

ENV HEALTCHECK_HOST $HEALTHCHECK_HOST

WORKDIR /vpn

ADD scripts/run.sh run.sh
ADD scripts/openconnect.sh openconnect.sh
ADD scripts/hipreport.sh hipreport.sh
ADD scripts/master.zip master.zip

RUN ln -fs /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

RUN apt-get update && apt-get -y install bash iproute2 iputils-ping iptables \
mtr net-tools openconnect python3-cairo python3-pip python3-pkgconfig \
python3-gi tcpdump vim strace rxvt xterm less gir1.2-gtk-3.0 \
python3-pyqt5 python3-pyqt5.qtwebkit python3-pyqt5.qtwebengine \
gir1.2-webkit2-4.0

RUN pip install master.zip
ADD scripts/gp_saml_gui.py /usr/local/lib/python3.9/dist-packages/gp_saml_gui.py

HEALTHCHECK  --interval=10s --timeout=10s --start-period=10s \
  CMD ping -c 3 $HEALTHCHECK_HOST

# MUST FIX UP /etc/hosts

# CMD ["/vpn/entrypoint.sh"]
CMD ["/vpn/run.sh"]
