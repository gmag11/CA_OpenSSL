#!/bin/bash

source .env

CURRDIR=$(echo $PWD | sed 's_/_\\/_g')

# openssl_root.cnf
cp openssl_root.cnf.template openssl_root.cnf
sed -i "s/#DIRECTORY#/${CURRDIR}/" openssl_root.cnf
sed -i "s/#DOMAIN_NAME#/${DOMAIN_NAME}/" openssl_root.cnf
sed -i "s/#DOMAIN#/${DOMAIN}/" openssl_root.cnf
sed -i "s/#COUNTRY#/${COUNTRY}/" openssl_root.cnf
sed -i "s/#STATE#/${STATE}/" openssl_root.cnf
sed -i "s/#CITY#/${CITY}/" openssl_root.cnf
sed -i "s/#COMPANY#/${COMPANY}/" openssl_root.cnf
sed -i "s/#COMP_UNIT#/${COMP_UNIT}/" openssl_root.cnf
sed -i "s/#EMAIL#/${EMAIL}/" openssl_root.cnf

# openssl_intermediate.cnf
cp intermediate/openssl_intermediate.cnf.template intermediate/openssl_intermediate.cnf
sed -i "s/#DIRECTORY#/${CURRDIR}/" intermediate/openssl_intermediate.cnf
sed -i "s/#DOMAIN_NAME#/${DOMAIN_NAME}/" intermediate/openssl_intermediate.cnf
sed -i "s/#DOMAIN#/${DOMAIN}/" intermediate/openssl_intermediate.cnf
sed -i "s/#COUNTRY#/${COUNTRY}/" intermediate/openssl_intermediate.cnf
sed -i "s/#STATE#/${STATE}/" intermediate/openssl_intermediate.cnf
sed -i "s/#CITY#/${CITY}/" intermediate/openssl_intermediate.cnf
sed -i "s/#COMPANY#/${COMPANY}/" intermediate/openssl_intermediate.cnf
sed -i "s/#COMP_UNIT#/${COMP_UNIT}/" intermediate/openssl_intermediate.cnf
sed -i "s/#EMAIL#/${EMAIL}/" intermediate/openssl_intermediate.cnf

# openssl_server.cnf
cp intermediate/openssl_server.cnf.template intermediate/openssl_server.cnf
sed -i "s/#DIRECTORY#/${CURRDIR}/" intermediate/openssl_server.cnf
sed -i "s/#DOMAIN_NAME#/${DOMAIN_NAME}/" intermediate/openssl_server.cnf
sed -i "s/#DOMAIN#/${DOMAIN}/" intermediate/openssl_server.cnf
sed -i "s/#COUNTRY#/${COUNTRY}/" intermediate/openssl_server.cnf
sed -i "s/#STATE#/${STATE}/" intermediate/openssl_server.cnf
sed -i "s/#CITY#/${CITY}/" intermediate/openssl_server.cnf
sed -i "s/#COMPANY#/${COMPANY}/" intermediate/openssl_server.cnf
sed -i "s/#COMP_UNIT#/${COMP_UNIT}/" intermediate/openssl_server.cnf
sed -i "s/#EMAIL#/${EMAIL}/" intermediate/openssl_server.cnf