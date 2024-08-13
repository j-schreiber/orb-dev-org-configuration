#! /bin/bash
# shellcheck disable=SC1091,SC2154

jwtpath=certs/server.key

while getopts j: option; do
    case "${option}" in
    j) jwtpath=${OPTARG} ;;
    *) ;;
    esac
done

source scripts/.config/cert-params.conf

# create certificate signing request
openssl req -new -key "$jwtpath" -out certs/server.csr -subj "$subject"
# generate a self-signed certificate using the server.key and server.csr
openssl x509 -req -sha256 -days 365 -in certs/server.csr -signkey certs/server.key -out certs/server.crt
# encode the server.key with base64. This will be used as environment variable in CircleCI
base64 -i certs/server.key
