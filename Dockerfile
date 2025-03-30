FROM archlinux:multilib-devel

ARG UID=1000
ARG GID=1000
ENV SETUP_URL="https://download.mql5.com/cdn/web/metaquotes.software.corp/mt5/mt5setup.exe"

RUN groupadd -g $GID mt5 && \
    useradd -u $UID -g $GID -m mt5

RUN pacman -Sy --noconfirm --needed \
    wget \
    xorg-server-xvfb \
    vulkan-icd-loader

RUN wget -q https://archive.archlinux.org/packages/w/wine/wine-10.0-1-x86_64.pkg.tar.zst && \
    pacman -U --noconfirm wine-10.0-1-x86_64.pkg.tar.zst && \
    rm wine-10.0-1-x86_64.pkg.tar.zst && \
    pacman -S --noconfirm winetricks wine-mono wine-gecko && pacman -Scc --noconfirm

USER mt5
WORKDIR /home/mt5

RUN xvfb-run winetricks -q corefonts esent vcrun2019

RUN mkdir program && \
    wget -O setup.exe $SETUP_URL && \
    timeout 30s xvfb-run -s "-screen 0 1280x1024x24" wine setup.exe /auto || true && \
    cp -R ".wine/drive_c/Program Files/MetaTrader 5"/* program/ && \
    timeout 20s xvfb-run -s "-screen 0 1280x1024x24" wine program/terminal64.exe || true && \
    rm -rf program/MQL5/Experts/* program/MQL5/Profiles/Templates/* setup.exe ".wine/drive_c/Program Files/MetaTrader 5/"