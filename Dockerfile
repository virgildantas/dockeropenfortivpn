FROM ubuntu:18.04


ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install -y -o APT::Install-Recommends=false -o APT::Install-Suggests=false \
  ca-certificates \
  expect \
  net-tools \
  iproute2 \
  ipppd \
  iptables \
  wget \
  && apt-get clean -q && apt-get autoremove --purge

WORKDIR /root

RUN apt-get install openfortivpn network-manager-fortisslvpn network-manager-fortisslvpn-gnome network-manager-openvpn network-manager-openvpn-gnome -y

RUN  rm -rf /var/lib/apt/lists/*

COPY vpn.config /root/
COPY start.sh /root/

CMD [ "/root/start.sh" ]
