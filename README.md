# pixelserv-tls
It will run the tiny pixelserv-tls web server which will respond to all requests with just a 1pxl image.
More info here: https://github.com/kvic-z/pixelserv-tls

A certificate is automaticaly generated at built step.
To get it: http://127.0.0.1/ca.crt

# Usage:
`docker run -d` \
` --name pixelserv-tls` \
` -p 80:80 -p 443:443` \
`imthai/pixelserv-tls`


# Best way to use it:

The best way is to stock the certificates ( the root certificates and the fake certificates that will be created on the fly) to a folder on the host. So you back it up easily. 
So you should proceed like that:
1) You run the container once
2) You get the generated ca.crt & ca.key
`docker  cp pixelserv-tls:/var/cache/pixelserv/ca.crt .`
`docker  cp pixelserv-tls:/var/cache/pixelserv/ca.key .`
3) You stop & rm the container
4) You create a dedicated folder on the host ( let say ~/pixelserv) where you put the ca.crt & ca.key
5) you run again the container like that:
`docker run -d` \
` --name pixelserv-tls` \
` -p 80:80 -p 443:443` \
` -v ~/pixelserv:/var/cache/pixelserv`\ 
`imthai/pixelserv-tls`


# Infos:
Shell access whilst the container is running: `docker exec -it pixelserv-tls /bin/sh`
