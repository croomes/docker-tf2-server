# ruippeixotog/tf2-server Docker image

This repository contains the Dockerfile for `ruippeixotog/tf2-server`, a Docker image containing a dedicated Team Fortress 2 server. The original Dockerfile is from [Gonzih](https://github.com/Gonzih) and is available [here](https://github.com/Gonzih/docker-tf2-server).

This image is built with the autoupdate flag (-autoupdate) enabled, which means the server attempts to auto-update itself when an update comes out.

## How to run

You can simply run the image with the default settings:

```
docker run -d -p 27015:27015/udp ruippeixotog/tf2-server
```

You can also specify the server settings explicitly:

```
docker run -d -p 27015:27015/udp ruippeixotog/tf2-server +sv_pure 2 +map \
  ctf_2fort.bsp +maxplayers 32
```

## Ports

* **27015/udp** - The main connection port, allowing clients to connect.
* **27015/tcp** - RCON port to manage server using admin tools
