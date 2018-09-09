# docker-pixelserv-tls
It will run the tiny pixelserv-tls web server which will respond to all requests with just a 1pxl image.

More info here: https://github.com/kvic-z/pixelserv-tls

`docker image pull trickyboy:pixelserv-tls`

`docker run -d --name pixelserv-tls -p 80:80 -p 443:443 trickyboy/pixelserv-tls`


A certificate is automaticaly generated at built step.
To get it: http://127.0.0.1/ca.crt
