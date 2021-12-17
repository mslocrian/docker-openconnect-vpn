#!/bin/bash

gp-saml-gui --gateway --clientos=Windows $VPN_ENDPOINT > /tmp/vpn_env
ret=$?

if [ $ret -ne 0 ]; then
    echo "Could not obtain SAML token!"
    exit $ret
fi

if [ ! -f /tmp/vpn_env ]; then
    echo "Could not find vpn environment"
    exit 1
fi

echo "$DOCKER_BRIDGE_ADDRESS $OUTSIDE_HOST" >> /etc/hosts

source /tmp/vpn_env
/vpn/openconnect.sh
