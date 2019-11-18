#!/bin/bash

OPENCONNECT_COMMAND="openconnect $OPENCONNECT_SERVER --user=$OPENCONNECT_USER --passwd-on-stdin"

if [ x${OPENCONNECT_GROUP} != "x" ]; then
    OPENCONNECT_COMMAND+=" -g $OPENCONNECT_GROUP"
fi

if [ x${OPENCONNECT_SERVER_CERT_HASH} != "x" ]; then
    echo "running echo $OPENCONNECT_COMMAND --servercert $OPENCONNECT_SERVER_CERT_HASH $OPENCONNECT_ADDITIONAL_ARGUMENTS"
    echo $OPENCONNECT_PASSWORD | $OPENCONNECT_COMMAND --servercert $OPENCONNECT_SERVER_CERT_HASH $OPENCONNECT_ADDITIONAL_ARGUMENTS -b && iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
else
    echo running $OPENCONNECT_COMMAND $OPENCONNECT_ADDITIONAL_ARGUMENTS
    ( echo yes; echo $OPENCONNECT_PASSWORD ) | $OPENCONNECT_COMMAND $OPENCONNECT_ADDITIONAL_ARGUMENTS -b && iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
fi

# Going to hold off for a bit and then check the status of openconnect
while [ true ]; do
    sleep 60
    pidof openconnect > /dev/null
    if [ $? -ne 0 ]; then
        echo "OpenConnect has quit. Exiting..."
        iptables -t nat -D POSTROUTING -o tun0 -j MASQUERADE
        exit 1
    else
        echo "OpenConnect still running. Continuing..."
    fi
done
