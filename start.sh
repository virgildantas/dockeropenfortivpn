#!/bin/sh
ARQUIVO="/root/$VPNFILE"

# Setup masquerade, to allow using the container as a gateway
for iface in $(ip a | grep eth | grep inet | awk '{print $2}'); do
  iptables -t nat -A POSTROUTING -s "$iface" -j MASQUERADE
done

while [ true ]; do
  if ! grep -q "trusted-cert" "$ARQUIVO"; then
    echo "------------ Get trust Certificate ------------"
    VPNCERT=$(openfortivpn -c $ARQUIVO | grep "trusted-cert = " | cut -d ":" -f2 | head -1 | sed 's/ //g')
    echo "\n$VPNCERT" >> $ARQUIVO
  fi
    echo "------------ VPN Starts ------------"
    openfortivpn -c $ARQUIVO
    echo "------------ VPN exited ------------"
    sleep 10
done
