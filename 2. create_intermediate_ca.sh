#!/bin/bash

source .env

# Create directory structure
# mkdir intermediate

# Create your intermediary CA database to keep track of signed certificates
mkdir intermediate/certs intermediate/crl intermediate/csr intermediate/private
touch intermediate/index.txt
touch intermediate/index.txt.attr
echo 1000 > intermediate/serial

# Create a crlnumber file for the intermediary CA to use
echo 1000 > intermediate/crlnumber

# copy openssl_intermediate.cnf

# Create the Intermediary's Private Key and Certificate Signing Request
openssl req -config intermediate/openssl_intermediate.cnf -new -newkey ec:<(openssl ecparam -name secp384r1) -keyout intermediate/private/${INT_CA_FILE_PREFIX}.key.pem -out intermediate/csr/${INT_CA_FILE_PREFIX}.csr -passout pass:${INT_CA_KEY_PASS}

# Create the intermediate certificate
openssl ca -config openssl_root.cnf -extensions v3_intermediate_ca -days 3600 -md sha384 -in intermediate/csr/${INT_CA_FILE_PREFIX}.csr -out intermediate/certs/${INT_CA_FILE_PREFIX}.crt.pem -passin pass:${CA_KEY_PASS}

#Validate the Certificate Contents with OpenSSL
openssl x509 -noout -text -in intermediate/certs/${INT_CA_FILE_PREFIX}.crt.pem