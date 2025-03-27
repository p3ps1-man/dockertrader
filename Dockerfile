FROM archlinux:latest

ARG UID=1000
ARG GID=1000
ENV SETUP_URL="https://download.mql5.com/cdn/web/metaquotes.software.corp/mt5/mt5setup.exe"

RUN groupadd -g $GID mt5 && \
    useradd -u $UID -g $GID -m mt5

RUN echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

RUN pacman -Syu --noconfirm \
    xorg-xinit \
    winetricks \
    wget \
    xorg-server-xvfb \
    vulkan-icd-loader

RUN wget https://archive.archlinux.org/packages/w/wine/wine-10.0-1-x86_64.pkg.tar.zst
RUN pacman -U --noconfirm wine-10.0-1-x86_64.pkg.tar.zst
RUN pacman -S --noconfirm wine-mono wine-gecko

USER mt5
WORKDIR /home/mt5

RUN wget -O setup.exe $SETUP_URL
RUN xvfb-run winetricks -q corefonts esent vcrun2019
RUN wineboot -u

RUN Xvfb :99 -screen 0 1024x768x24 & \
        sleep 20 && \
        export DISPLAY=:99 && \
        timeout 30s xvfb-run wine setup.exe /auto || true
        

RUN mkdir program
RUN cp -R "./.wine/drive_c/Program Files/MetaTrader 5"/* program/
RUN timeout 30s wine program/terminal64.exe || true
RUN rm -rf program/MQL5/Experts/* && rm -rf program/MQL5/Profiles/Templates/*

CMD ["wine", "./program/terminal64.exe"]