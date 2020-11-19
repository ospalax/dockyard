#!/bin/sh

set -e

# setup basic auth credentials
if ! [ -f "${REGISTRY_AUTH_HTPASSWD_PATH}" ] ; then
    echo "Setup the regular registry user: ${REGISTRY_BASIC_AUTH_USERNAME}"
    htpasswd -Bbn \
        "${REGISTRY_BASIC_AUTH_USERNAME}" \
        "${REGISTRY_BASIC_AUTH_PASSWORD}" \
        > "${REGISTRY_AUTH_HTPASSWD_PATH}"

    echo "Setup the privileged registry user: ${REGISTRY_BASIC_AUTH_PRIVILEGED_USERNAME}"
    htpasswd -Bbn \
        "${REGISTRY_BASIC_AUTH_PRIVILEGED_USERNAME}" \
        "${REGISTRY_BASIC_AUTH_PRIVILEGED_PASSWORD}" \
        >> "${REGISTRY_AUTH_HTPASSWD_PATH}"
fi

# setup privileged group
if ! [ -f "${REGISTRY_AUTH_HTPASSWD_GROUPS_PATH}" ] ; then
    echo "Setup the privileged registry group: ${REGISTRY_AUTH_HTPASSWD_PRIVILEGED_GROUP}"
    printf "%s: %s\n" \
        "${REGISTRY_AUTH_HTPASSWD_PRIVILEGED_GROUP}" \
        "${REGISTRY_BASIC_AUTH_PRIVILEGED_USERNAME}" \
        > "${REGISTRY_AUTH_HTPASSWD_GROUPS_PATH}"
fi

exit 0
