#!/bin/bash

source .env

echo "Enter subdomain without $DOMAIN ending"
read SUBDOMAIN
echo "Enter private key password"
read -s KEY_PASS
echo "Repeat key password"
read -s KEY_PASS_1

if [[ "$KEY_PASS" != "$KEY_PASS_1" ]]
then
  # echo "Passwords do not match $KEY_PASS - $KEY_PASS_1"
  exit 1
fi

#echo Password is ${KEY_PASS}

# Create the private key and CSR
openssl req -config intermediate/openssl_server.cnf -new -newkey ec:<(openssl ecparam -name secp384r1) -keyout intermediate/private/${SUBDOMAIN}.${DOMAIN}.key.pem -out intermediate/csr/${SUBDOMAIN}.${DOMAIN}.csr -passout pass:${KEY_PASS}

# Decrypt key
openssl ec -in intermediate/private/${SUBDOMAIN}.${DOMAIN}.key.pem -out intermediate/private/${SUBDOMAIN}.${DOMAIN}.key -passin pass:${KEY_PASS}

# Create the Certificate
openssl ca -config intermediate/openssl_server.cnf -extensions server_cert -days 360 -in intermediate/csr/${SUBDOMAIN}.${DOMAIN}.csr -out intermediate/certs/${SUBDOMAIN}.${DOMAIN}.crt.pem -passin pass:${INT_CA_KEY_PASS}

# Validate the certificate
openssl x509 -noout -text -in intermediate/certs/${SUBDOMAIN}.${DOMAIN}.crt.pem