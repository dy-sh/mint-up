#!/bin/bash
# Copyright Dmitry Savosh (d.savosh@gmail.com)

# e - stop script if error
# u - stop script if using uninitialized variable
set -eu 

# set colors
NC=$(tput sgr0)
BOLD=$(tput bold)
RED="${BOLD}$(tput setaf 1)"
GREEN="${BOLD}$(tput setaf 2)"
YELLOW="${BOLD}$(tput setaf 3)"
BLUE="${BOLD}$(tput setaf 4)"
MAGENTA="${BOLD}$(tput setaf 5)"
CYAN="${BOLD}$(tput setaf 6)"
WHITE="${BOLD}$(tput setaf 7)"
# set message tags
UP="\e[1A\e[K"
INFO="[....]"
NOTE="[${WHITE}NOTE${NC}]"
OK="[${GREEN} OK ${NC}]"
ACTN="[${CYAN}ACTN${NC}]"
WARN="[${YELLOW}WARN${NC}]"
ERR="[${RED}ERR!${NC}]"
HEADER="${BLUE}\n--------------------------------------------------------------${NC}\n"

# cd to script directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR" || exit

# ---------------------------------------------------------------------

echo -e "$HEADER Configuring JetBrains IDEs $HEADER"

echo -e "$INFO Instaliing JetBrains IDE shorturts"


# check if script running on linux mint
if [[ ! -f /etc/linuxmint/info ]]; then
    echo -e "$OK Not required on this distro"
    exit
fi

# To create icon manualy, On the Welcome screen, click Configure | Create Desktop Entry
# Or From the main menu, click Tools | Create Desktop Entry

# CLion
if [[ ! -f /usr/share/applications/jetbrains-clion.desktop && ! -f /usr/share/applications/clion.desktop ]]; then
    app_folder="/opt/clion"
    if [[ -d "$app_folder" ]]; then
        echo -e "$INFO Instaliing JetBrains CLion shorturt"
        sudo rm -f /usr/share/applications/clion.desktop 

        echo "[Desktop Entry]
Version=1.0
Type=Application
Name=CLion
Icon=$app_folder/bin/clion.svg
Exec="$app_folder/bin/clion.sh" %f
Comment=A cross-platform IDE for C and C++
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-clion
StartupNotify=true" | sudo tee --append /usr/share/applications/jetbrains-clion.desktop  > /dev/null
    else
        echo -e "\n${YELLOW} JetBrains CLion is not installed! Skipping! ${NC}\n"
    fi
else
    echo -e "\n JetBrains CLion shorturt aclready installed! Skipping! \n"
fi

# Rider

if [[ ! -f /usr/share/applications/jetbrains-rider.desktop && ! -f /usr/share/applications/rider.desktop ]]; then
    app_folder="/opt/rider"
    if [[ -d "$app_folder" ]]; then
        echo -e "$INFO Instaliing JetBrains Rider shorturt"
        sudo rm -f /usr/share/applications/rider.desktop 

        echo "[Desktop Entry]
Version=1.0
Type=Application
Name=Rider
Icon=$app_folder/bin/rider.svg
Exec="$app_folder/bin/rider.sh" %f
Comment=A cross-platform IDE for Unity and Unreal Engine
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-rider
StartupNotify=true" | sudo tee --append /usr/share/applications/jetbrains-rider.desktop  > /dev/null
    else
        echo -e "\n${YELLOW} JetBrains Rider is not installed! Skipping! ${NC}\n"
    fi
else
    echo -e "\n JetBrains Rider shorturt aclready installed! Skipping! \n"
fi


# WebStorm

if [[ ! -f /usr/share/applications/jetbrains-webstorm.desktop && ! -f /usr/share/applications/webstorm.webstorm ]]; then
    app_folder="/opt/webstorm"
    if [[ -d "$app_folder" ]]; then
        echo -e "$INFO Instaliing JetBrains WebStorm shorturt"
        sudo rm -f /usr/share/applications/webstorm.desktop

        echo -e "$INFO [Desktop Entry]
Version=1.0
Type=Application
Name=WebStorm
Icon=$app_folder/bin/webstorm.svg
Exec="$app_folder/bin/webstorm.sh" %f
Comment=A cross-platform IDE for Web
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-webstorm
StartupNotify=true" | sudo tee --append /usr/share/applications/jetbrains-webstorm.desktop  > /dev/null
    else
        echo -e "\n${YELLOW} JetBrains WebStorm is not installed! Skipping! ${NC}\n"
    fi
else
    echo -e "\n JetBrains WebStorm shorturt aclready installed! Skipping! \n"
fi

# PyCharm

if [[ ! -f /usr/share/applications/jetbrains-pycharm.desktop && ! -f /usr/share/applications/pycharm.desktop ]]; then
    app_folder="/opt/pycharm"
    if [[ -d "$app_folder" ]]; then
        echo -e "$INFO Instaliing JetBrains PyCharm shorturt"
        sudo rm -f /usr/share/applications/pycharm.desktop 

    # for pycharm professional use StartupWMClass=jetbrains-pycharm

        echo "[Desktop Entry]
Version=1.0
Type=Application
Name=PyCharm Community Edition
Icon=$app_folder/bin/pycharm.svg
Exec="$app_folder/bin/pycharm.sh" %f
Comment=Python IDE for Professional Developers
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-pycharm-ce
StartupNotify=true" | sudo tee --append /usr/share/applications/jetbrains-pycharm.desktop  > /dev/null
    else
        echo -e "\n${YELLOW} JetBrains PyCharm is not installed! Skipping! ${NC}\n"
    fi
else
    echo -e "\n JetBrains PyCharm shorturt aclready installed! Skipping! \n"
fi

echo -e "$OK DONE"



