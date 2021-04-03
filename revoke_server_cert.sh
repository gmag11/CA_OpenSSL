#!/bin/bash

source .env

echo "Enter subdomain without $DOMAIN ending"
read SUBDOMAIN

echo "Do you want to revoke certificate for ${SUBDOMAIN}.${DOMAIN}? (y/n)"
read RESPONSE

if [[ "$RESPONSE" != "y" ]]
then
  exit 1
fi

# Create the private key and CSR
openssl ca -revoke intermediate/certs/${SUBDOMAIN}.${DOMAIN}.crt.pem -config intermediate/openssl_intermediate.cnf -crl_reason superseded -passin pass:${INT_CA_KEY_PASS}

# Update revoke list
openssl ca -gencrl -config intermediate/openssl_intermediate.cnf -out intermediate/crl/${CRL_PREFIX}.crl -passin pass:${INT_CA_KEY_PASS}