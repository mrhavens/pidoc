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

### Install Docker
```
sudo apt -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
apt-cache policy docker-ce
sudo apt -y install docker-ce
```

### Clone Repository

```
git clone https://github.com/mrhavens/pidoc.git
cd pidoc
```

### Build Image

The `Dockerfile` is used to build two containers. The first container is the build container that includes all the dependencies for compiling QEMU, and the other is the app container for running QEMU.

```
docker build -t pidoc .
```

### Configure Cluster

Docker Compose is used for cluster creation. `ssh` is redirected from port `2222` inside the container to random ports within the specified range, as below.

```
# docker-compose.yml
#

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

### Install Ansible

```
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible -y
```

### Ansible Configuration

To manage the cluster, once the containers start and Raspbian boots, ssh will be enabled and become available to Ansible. A few basic operations are provided here: `update`, `upgrade`, `reboot`, and `shutdown`. These can be expanded as needed to develop a more robust system.

Please note of the ports we specified in the `docker-compose.yml` file earlier, and edit your `hosts` inventory accordingly.
```
# hosts inventory
#

[all:vars]
ansible_user=pi
ansible_ssh_pass=raspberry
ansible_ssh_extra_args='-o StrictHostKeyChecking=no'

[pidoc-cluster]
node_1.localhost:2201
node_2.localhost:2202
node_3.localhost:2203
```

## Attribution

Thanks goes to:
- [Luke Childs](https://github.com/lukechilds) for [dockerpi](https://github.com/lukechilds/dockerpi)
- [Dhruv Vyas](https://github.com/dhruvvyas90) for [qemu-rpi-kernel](https://github.com/dhruvvyas90/qemu-rpi-kernel)
- [Pavlos Ratis](https://github.com/dastergon) for [ansible-rpi-cluster](https://github.com/dastergon/ansible-rpi-cluster)
