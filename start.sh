#!/bin/bash

EXE="$HOME/.wine/drive_c/Program Files/MetaTrader 5/terminal64.exe"
SETUP_URL="https://download.mql5.com/cdn/web/metaquotes.software.corp/mt5/mt5setup.exe"

if [ -f "$EXE" ]; then
    echo "MetaTrader is already installed. Starting MetaTrader..."
    wine "$EXE"
else
    echo "MetaTrader is not installed. Starting installation..."
    winetricks corefonts
    wait
    
    wget -O setup.exe "$SETUP_URL"
    wine setup.exe /auto
    wait

    echo "Installing metatrader..."
    wait
    
    if [ -f "$EXE" ]; then
        echo "MetaTrader installation completed successfully. Starting MetaTrader..."
        wine "$EXE"
    else
        echo "MetaTrader installation failed. Please check the installation process."
    fi
fi