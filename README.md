# Metatrader 5 docker image

This is a base image of docker running MetaTrader 5 using wine. This image is published on [Dockerhub](https://hub.docker.com/repository/docker/p3ps1man/dockertrader). X11 server is already pre-configured.

## Features

- Preinstalled MetaTrader 5

## Requirements

- Docker installed on your machine.

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


