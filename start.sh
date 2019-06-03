#!/bin/bash

set -ex

KEY="${TUNNELD_CERT_DIR}/tunneld.key"
CERT="${TUNNELD_CERT_DIR}/tunneld.crt"

if ! { [ -f "${KEY}" ] && [ -f "${CERT}" ] ; } ; then
    echo "Generating SSL key and certificate at ${KEY} and ${CERT}"
    openssl req -x509 -nodes -newkey rsa:2048 -sha256 -keyout "${KEY}" -out "${CERT}" \
        -subj "/C=${COUNTRY_CODE}/ST=${STATE_CODE}/L=${LOCALITY_NAME}/O=${ORGANIZATION_NAME}/OU=${ORG_UNIT_NAME}/CN=${COMMON_NAME}"
    chmod +r "${KEY}"
fi

tunneld -tlsCrt "${CERT}" -tlsKey "${KEY}"
