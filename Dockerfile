FROM archlinux:latest

ARG UID=1000
ARG GID=1000
ENV SETUP_URL="https://download.mql5.com/cdn/web/metaquotes.software.corp/mt5/mt5setup.exe"
ENV IE_URL="https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/f2910a1e-e5a6-4f17-b52d-7faf525d17f8/MicrosoftEdgeWebview2Setup.exe"

RUN groupadd -g $GID mt5 && \
    useradd -u $UID -g $GID -m mt5

RUN echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

RUN pacman -Sy --noconfirm --needed \
    wget \
    xorg-server-xvfb \
    vulkan-icd-loader \
    wine \
    winetricks \
    wine-mono \
    wine-gecko \
    supervisor \
    && pacman -Scc --noconfirm

USER mt5
WORKDIR /home/mt5

RUN xvfb-run winetricks -q corefonts
RUN xvfb-run winetricks -q vcrun2019

RUN xvfb-run winecfg -v win10 && \
    wget -O webview2.exe $IE_URL && \
    timeout 300s xvfb-run -s "-screen 0 1280x1024x24" wine webview2.exe /silent /install || true

RUN mkdir program && \
    wget -O setup.exe $SETUP_URL && \
    timeout 100s xvfb-run -s "-screen 0 1280x1024x24" wine setup.exe /auto || true && \
    timeout 100s xvfb-run -s "-screen 0 1280x1024x24" wine program/terminal64.exe || true

USER root
COPY privilege_fix.sh privilege_fix.sh
RUN chmod +x privilege_fix.sh
ENTRYPOINT ["./privilege_fix.sh"]