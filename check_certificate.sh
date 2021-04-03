#!/bin/bash

source .env

echo "Enter subdomain without $DOMAIN ending"
read SUBDOMAIN

echo "This will test ${SUBDOMAIN}.${DOMAIN} certificate against its private key"

KEY_SHA=`openssl pkey -in intermediate/private/${SUBDOMAIN}.${DOMAIN}.key -pubout -outform pem | sha256sum`

CERT_SHA=`openssl x509 -in intermediate/certs/${SUBDOMAIN}.${DOMAIN}.crt.pem -pubkey -noout -outform pem | sha256sum`

# echo $KEY_SHA
# echo $CERT_SHA

if [[ ${KEY_SHA} == ${CERT_SHA} ]]
then
  echo "Certificate matches private key"
else
  echo "Certificate does not match private key"
fi
