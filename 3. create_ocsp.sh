#!/bin/bash

source .env

# Create the CRL
openssl ca -config intermediate/openssl_intermediate.cnf -gencrl -out intermediate/crl/${CRL_PREFIX}.crl -passin pass:${INT_CA_KEY_PASS}

# Validate the CRL with OpenSSL
openssl crl -in intermediate/crl/${CRL_PREFIX}.crl -noout -text

# Copy openssl_server.cnf

# Create the OCSP key & certificate
openssl req -config intermediate/openssl_server.cnf -new -newkey ec:<(openssl ecparam -name secp384r1) -keyout intermediate/private/${OCSP_PREFIX}.key.pem -passout pass:${OCSP_KEY_PASS} -out intermediate/csr/${OCSP_PREFIX}.csr.pem -extensions server_cert

# Sign the CSR with our Intermediary Certificate Authority
openssl ca -config intermediate/openssl_intermediate.cnf -extensions ocsp -days 365 -notext -md sha384 -in intermediate/csr/${OCSP_PREFIX}.csr.pem -out intermediate/certs/${OCSP_PREFIX}.crt.pem -passin pass:${INT_CA_KEY_PASS}

# Verify the certificate's usage is set for OCSP
openssl x509 -noout -text -in intermediate/certs/${OCSP_PREFIX}.crt.pem