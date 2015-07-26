#!/bin/bash

:<<-USAGE
See https://github.com/frntn/x509-san/blob/master/README.md
USAGE

issuer_subject="/C=${CRT_C:-"FR"}/L=${CRT_L:-"Paris"}/O=${CRT_O:-"Ekino"}/OU=${CRT_OU:-"DevOps"}/CN=${CRT_CN:-"base.example.com"}"
alternative_name="subjectAltName=${CRT_SAN:-"DNS.1:logs.example.com,DNS.2:metrics.example.com,IP.1:192.168.0.1,IP.2:10.0.0.50"}"
certname=${CRT_NAME:-"frntn-x509-san"}
digest=${CRT_DIGEST:-"sha256"}

openssl x509 \
 -in <(openssl req \
	-days 3650 \
	-newkey rsa:4096 \
	-nodes \
	-keyout "${certname}.key" \
	-subj ${issuer_subject}) \
 -req \
 -signkey "${certname}.key" \
 -days 3650 \
 -${digest} \
 -out "${certname}.crt" \
 -extfile <(echo ${alternative_name})
