# htpasswd directory

**NOTE**:
  This file (at the least) enforces git to add this directory to the repo so it can be used as a volume/bindmount in the `docker-compose.yml`.

You can store your custom `htpasswd` here which can then be referenced via `REGISTRY_AUTH_HTPASSWD_PATH`.
