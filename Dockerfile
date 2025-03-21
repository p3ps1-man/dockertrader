FROM archlinux:latest

ARG UID=1000
ARG GID=1000

RUN groupadd -g $GID mt5 && \
    useradd -u $UID -g $GID -m mt5 && \
    usermod -aG root mt5

RUN echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

RUN pacman -Syu --noconfirm \
    xorg-xinit \
    winetricks \
    wget

RUN wget https://archive.archlinux.org/packages/w/wine/wine-10.0-1-x86_64.pkg.tar.zst
RUN pacman -U --noconfirm wine-10.0-1-x86_64.pkg.tar.zst

RUN pacman -S --noconfirm wine-mono wine-gecko

COPY start.sh /home/mt5/start.sh
RUN chmod +x /home/mt5/start.sh

USER mt5

WORKDIR /home/mt5

ENTRYPOINT ["./start.sh"]

#docker volume create mt5
#docker build -t mt5 .
#docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v mt5:/home/mt5 mt5
#xhost +local:root
# COPY start.sh /start.sh
# RUN chmod +x /start.sh