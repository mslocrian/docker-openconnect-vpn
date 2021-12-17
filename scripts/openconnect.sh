#!/bin/bash

echo $COOKIE | openconnect --protocol=gp -b -u $USER $ADDITIONAL_VPN_ARGS --os=$OS --passwd-on-stdin --csd-wrapper=/vpn/hipreport.sh $HOST
res=$?
if [ $res -ne 0 ]; then
    echo "OpenConnect could not successfully start. exiting..."
	exit $res
fi

SLEEP_TIME=10
echo "Sleeping for $SLEEP_TIME seconds so VPN can sort itself out."
sleep $SLEEP_TIME 

echo "Executing iptables nat rules."
iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE

echo "Executing additional commands."
$ADDITIONAL_COMMANDS

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
