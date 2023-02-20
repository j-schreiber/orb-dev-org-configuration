#! /bin/bash

password=

while getopts p: option
do
    case "${option}" in
        p )             password=${OPTARG};;
        * )
    esac
done

rm -rf certs
mkdir -p certs

# generate private key file
openssl genrsa -des3 -passout pass:"$password" -out certs/server.pass.key 2048
# use the private key file, to create server certificate
openssl rsa -passin pass:"$password" -in certs/server.pass.key -out certs/server.key
# create certificate signing request
openssl req -new -key certs/server.key -out certs/server.csr
# generate a self-signed certificate using the server.key and server.csr
openssl x509 -req -sha256 -days 365 -in certs/server.csr -signkey certs/server.key -out certs/server.crt
# encode the server.key with base64. This will be used as environment variable in CircleCI
base64 -i certs/server.key
