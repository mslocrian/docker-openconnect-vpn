# Docker AnyConnect VPN
The goal here is to be able to provide AnyConnect VPN connectivity via a 
docker container. 

I've experienced issues with AnyConnect and its desire to take over the
system routing table, and bugs where its failure can cause other host 
based networking issue.

To work around this, I wanted to get the VPN isolated into its own docker
container, where it can do what it likes within the container context, but
hopefully not affect much outside that.

Once the tunnel comes up, then you can route whatever traffic you like
over the assigned ip address (172.32.0.200 from docker-compose.yml).

Note that I run this on an Ubuntu desktop.  I also run Quagga (zebra) on the 
local machine, and have a bunch of /32 static routes routing to the 
172.32.0.200 docker address. You can manage it however you prefer, though.

Any fixes and improvements are welcome!

## Credit
This was taken and modified from: 
https://github.com/jetbrains-infra/docker-anyconnect-vpn

# Usage
## Environment Variables
Set up some environment variables
`OPENCONNECT_SERVER` - The Cisco AnyConnect VPN server to connect to
`OPENCONNECT_USER` - Your username
`OPENCONNECT_PASSWORD` - Your password / OTP
`OPENCONNECT_SERVER_CERT_HASH` - The certificate hash (if you omit this, you 
will see output from the openconnect client in the docker output).
`OPENCONNECT_GROUP` - The AnyConnect VPN Group associated with your account 
(if any)
`OPENCONNECT_ADDITIONAL_ARGUMENTS` - If you feel like passing any additional arguments to the openconnect CLI. (-vvv, --dump-http-traffic, or ???)

## CLI
```sh
$ docker-compose up --abort-on-container-exit
```
