# mrndrsn/tf2-server Docker image

This repository contains the Dockerfile for `mrndrsn/tf2-server`, a Docker image containing a dedicated Team Fortress 2 server running SourceMod. The original Dockerfile is from [Gonzih](https://github.com/Gonzih) and is available [here](https://github.com/Gonzih/docker-tf2-server).

This image is built with the autoupdate flag (-autoupdate) enabled, which means the server attempts to auto-update itself when an update comes out.

## How to run

### The easiest way?

```bash
curl https://raw.githubusercontent.com/anoldguy/docker-tf2-server/master/run_server.sh | bash -s -- +exec server.cfg
```

Yes, it's not normally safe to do pipe `curl` output to `bash`. So before you pipe random code from the internet into a shell on your computer that runs **AS YOU**, at least look the script over, mmmkay?

#### Options for the easy way:
The script will read environment variables for several bits of configuration, and will pass whatever you specify on the command line to the server.

```
SERVER_CFG_URL - Specify this if you have a custom config you want to use.
ADMIN_USERS_URL - Specify this if you have a SourceMod admins_simple.ini file you want to use.
CORE_CFG_URL - Specify this if you want to override the core SourceMod config.
```

So a super-custom invocation would look like this:
```

```

### The manual way:

You can simply run the image with the default settings:

```
docker run -d -p 27015:27015/udp mrndrsn/tf2-server
```

You can also specify the server settings explicitly:

```
docker run -d -p 27015:27015/udp mrndrsn/tf2-server +sv_pure 2 +map \
  ctf_2fort +maxplayers 32
```

## Ports

* **27015/udp** - The main connection port, allowing clients to connect.
* **27015/tcp** - RCON port to manage server using admin tools
