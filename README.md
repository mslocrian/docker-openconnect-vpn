# Docker AnyConnect VPN
The goal here is to be able to provide PaloAlto GlobalConnect SAML Based
VPN connectivity via a docker container. 

This requires some X11 Forwarding, so you'll need to work that connectivity
out since a QT window will be displayed which handles the initial SAML 
authentication.

Once the tunnel comes up, then you can route whatever traffic you like
over the assigned ip address (172.32.0.200 from docker-compose.yml).

Note that I run this on an Ubuntu desktop.  I also run FRR (zebra) on the 
local machine, and have a bunch of /32 static routes routing to the 
172.32.0.200 docker address. You can manage it however you prefer, though.

Any fixes and improvements are welcome!

## Credit
This was taken and modified from: 
https://github.com/jetbrains-infra/docker-anyconnect-vpn
https://github.com/dlenski/gp-saml-gui - Modified from Gtk to QT. Pretty Ugly.

# Usage
## Environment Variables
Set up some environment variables:
- `VPN_ENDPOINT` - The PaloAlto GlobalConnect VPN Host
- `ADDITIONAL_VPN_ARGS` - If you feel like passing any additional arguments to openconnect CLI
- `ADDITIONAL_COMMANDS` - Run some additional commands after VPN comes up
- `OUTSIDE_HOSTNAME` - Need to pass the hostname of the docker host inside in for X11 (Updates /etc/hosts entry)
- `DOCKER_BRIDGE_ADDRESS` - The address of the docker bridge host. Typically first address of network defined in docker-compose.yaml
- `HEALTHCHECK_HOST` - Host inside the VPN to check health against. 

## CLI
```sh
$ docker-compose up --abort-on-container-exit
```
