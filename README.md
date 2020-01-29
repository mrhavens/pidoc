<div align="center">
	<img width="256" src="pidoc.png">
</div>


# pidoc

Please see main article [here](https://appfleet.com/blog/raspberry-pi-cluster-emulation-with-docker-compose/).

## tl;dr

An autoconfiguring stack to build simple, scalable, and fully binary compatible Raspberry Pi clusters running Raspbian.

## Stack

1. Linux (host OS)
2. Docker
3. QEMU (containerized inside Docker)
4. Raspbian (containerized inside QEMU)
5. Docker Compose
6. Ansible (on host)

## Attribution

Thanks goes to:
- [Luke Childs](https://github.com/lukechilds) for [dockerpi](https://github.com/lukechilds/dockerpi)
- [Dhruv Vyas](https://github.com/dhruvvyas90) for [qemu-rpi-kernel](https://github.com/dhruvvyas90/qemu-rpi-kernel)
