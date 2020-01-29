# pidoc

Please see original article [here](https://appfleet.com/blog/raspberry-pi-cluster-emulation-with-docker-compose/).

<div align="center">
	<img width="256" src="pidoc.png">
</div>

## TL;DR

An autoconfiguring stack to build simple, scalable, and fully binary ARM compatible Raspberry Pi clusters on Intel or AMD architecture.

## Stack

1. Linux (host OS)
2. Docker
3. QEMU (containerized inside Docker)
4. Raspbian (containerized inside QEMU)
5. Docker Compose
6. Ansible (on host)

### Build Image

Go to the main folder. We will be using the `Dockerfile` to build our two containers. The first will be our build container that includes all the dependencies for compiling QEMU, and the other will be our app container for running QEMU.

```
docker build -t pidoc .
```

### Configure Cluster

Docker Compose is used for cluster creation. `ssh` is redirected from port `2222` inside the container to random ports within the specified range, as below.

```
# docker-compose.yml
version: '3'

services:
  node:
    image: pidoc
    ports:
      - "2201-2203:2222"
```

### Build Cluster

To bring up three nodes as configured above with `docker-compose`, use the `--scale` option.

```
docker-compose up --scale node=3
```

## Attribution

Thanks goes to:
- [Luke Childs](https://github.com/lukechilds) for [dockerpi](https://github.com/lukechilds/dockerpi)
- [Dhruv Vyas](https://github.com/dhruvvyas90) for [qemu-rpi-kernel](https://github.com/dhruvvyas90/qemu-rpi-kernel)
- [Pavlos Ratis](https://github.com/dastergon) for [ansible-rpi-cluster](https://github.com/dastergon/ansible-rpi-cluster)
