#! /bin/sh
echo "pouet1"
# Generating the certificates:
if ! [[ $(find /var/cache/pixelserv -maxdepth 1 -name 'ca.*' -print -quit) ]];
then
  echo "pouet2"
  apk add easy-rsa
  cd /tmp
  /usr/share/easy-rsa/easyrsa init-pki
  yes Pixelserv-tls | /usr/share/easy-rsa/easyrsa build-ca nopass
  mv pki/private/ca.key pki/ca.crt /var/cache/pixelserv
  chown -R nobody /var/cache/pixelserv
  apk del easy-rsa
fi

pixelserv-tls -f -u root

exit
