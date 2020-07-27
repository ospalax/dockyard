#!/bin/sh

set -e

# setup basic auth credentials
if ! [ -f "${REGISTRY_AUTH_HTPASSWD_PATH}" ] ; then
    htpasswd -Bbn \
        "${BASIC_AUTH_USERNAME}" "${BASIC_AUTH_PASSWORD}" \
        > "${REGISTRY_AUTH_HTPASSWD_PATH}"
fi

exit 0
