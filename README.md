# dockyard

## Exemplary docker registry deployment

**DISCLAIMER**:

The deployment of Docker registry in this repo is **NOT** meant for any production use! This project is just an example and a reference how to deploy and use the official [docker registry](https://github.com/docker/distribution).

## Usage

**IMPORTANT**:

This should be given but for the successful deployment of the docker registry you must have installed [Docker](https://docker.com) and [`docker-compose`](https://docs.docker.com/compose/install/). Alternatively you can try to use [`podman`](https://github.com/containers/podman) and [`podman-compose`](https://github.com/containers/podman-compose) - although without any guarantees...tested with podman `2+` and podman-compose `0.1.7+`.

**NOTE**:

If you decide to go with `podman` and `podman-compose` instead of the `docker` cli tools then just replace all `docker` and `docker-compose` commands with their podman alternative.

**If you wish you can adjust the deployment by editing the `.env` file or `docker-compose.yml` directly.**

### Start registry

```
% docker-compose up -d
```

### Log into the registry

Before you can fully use this registry you must log first (when basic auth is used) - e.g.:
```
% docker login localhost:4443
```

### Push and Pull

First pull (from DockerHub for example) or build some image (from Dockerfile) - e.g.:
```
% docker pull hello-world
```

Create new tag - e.g.:
```
% docker image tag hello-world localhost:4443/myhello-world
```

Now push the image to our registry:
```
% docker push localhost:4443/myhello-world
```

Delete the local images and pull from our registry:
```
% docker image rm localhost:4443/myhello-world
% docker image rm hello-world
% docker pull localhost:4443/myhello-world
```

### Stop registry

```
% docker-compose down
```

### Maintenance

Cleanup - e.g.:
```
% docker exec -it dockyard_registry_1 registry garbage-collect --delete-untagged=true /etc/docker/registry/config.yml
```

## Notes

### Version

I am pinning the registry version to `2.7.0` due to the regression described here:
https://github.com/docker/distribution-library-image/issues/106

### Certs

The included example certificate is self-signed which requires extra step to use:
https://docs.docker.com/registry/insecure/#use-self-signed-certificates

e.g.:
```
% sudo mkdir -p /etc/docker/certs.d/localhost:4443/
% sudo cp ./certs/dockyard-example.crt /etc/docker/certs.d/localhost:4443/ca.crt
% sudo chmod 644 /etc/docker/certs.d/localhost:4443/ca.crt
```

