# Metatrader 5 docker image [![](https://img.shields.io/docker/pulls/p3ps1man/dockertrader)](https://hub.docker.com/r/p3ps1man/dockertrader)

This is a base image of docker running MetaTrader 5 using wine. X11 server is already pre-configured. This image is base for [dockertrader-x11](https://github.com/p3ps1-man/dockertrader-x11) which just runs the wine localy for development and [dockertrader-vnc](https://github.com/p3ps1-man/dockertrader-vnc) an headless container running novnc that can be monitored via browser.

## Features

- Preinstalled MetaTrader 5

## Requirements

- Docker installed on your machine.
- x86_64 cpu

## Usage

1. Clone repository:
```bash
git clone https://github.com/p3ps1-man/dockertrader.git
cd dockertrader
```

2. Build the Docker image:
```bash
docker build -t image-name .
```

3. Or just pull it from dockerhub:
```bash
docker pull p3ps1man/dockertrader
```

## Notice

Default user is mt5 and installation path is program directory inside its home directory ```/home/mt5/program``` from there you can access ```MQL5/Experts``` or other directories you need. Permissions are preconfigured for mt5 user with GID:1000 and UID:1000.


