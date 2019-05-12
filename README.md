# pixelserv-tls
It will run the tiny pixelserv-tls web server which will respond to all requests with just a 1pxl image.
More info here: https://github.com/kvic-z/pixelserv-tls

A certificate is automaticaly generated at built step.
To get it: http://127.0.0.1/ca.crt

# Best way to use it:

The best way is to stock the certificates ( the root certificates and the fake certificates that will be created on the fly) to a folder on the host. So you back it up easily. 
So you should proceed like that:  
1) You run the container once. It will generate a root certificates.  
`docker run -d \`  
` --name pixelserv-tls \`  
` -p 80:80 -p 443:443 \`  
`--restart always \`  
`imthai/pixelserv-tls`  
OR 
if you' r under linux, you can attach to the port of the host machine (best situation):  
`docker run -d \`  
` --name pixelserv-tls \`
` --net=host \`   
`--restart always \`  
`imthai/pixelserv-tls`

2) You copy the generated ca.crt & ca.key to your host.  
`docker  cp pixelserv-tls:/var/cache/pixelserv/ca.crt .`  
`docker  cp pixelserv-tls:/var/cache/pixelserv/ca.key .`   

3) You delete the container  
`docker rm -f pixelserv-tls`  

4) You create a dedicated folder on the host ( let's say ~/pixelserv) where you put the ca.crt & ca.key  

5) Then you run again the container, using this time a specific volume pointing to the folder where you've put the certs:  
`docker run -d \`  
` --name pixelserv-tls \`   
` -p 80:80 -p 443:443 \`  
`--restart always \`  
`imthai/pixelserv-tls`  
OR 
if you' r under linux, you can attach to the port of the host machine (best situation):  
`docker run -d \`  
` --name pixelserv-tls \`  
` --net=host \`  
`--restart always \`  
`imthai/pixelserv-tls`


# Infos:
Shell access whilst the container is running: `docker exec -it pixelserv-tls /bin/sh`
