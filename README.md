# `pidoc`

## TL;DR

Use `pidoc`'s autoconfigured stack to build simple, scalable, and fully binary compatible Raspberry Pi clusters running Raspbian.

`pidoc`'s stack:
1. Linux (host OS)
2. Docker
3. QEMU (containerized inside Docker)
4. Raspbian (containerized inside QEMU)
5. Docker Compose
6. Ansible (on host)

Please see main article [here](https://appfleet.com/blog/raspberry-pi-cluster-emulation-with-docker-compose/).
