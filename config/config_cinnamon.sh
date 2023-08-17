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

./download_cinnamon_applets.sh
./install_cinnamon_applets.sh

echo -e "$HEADER Configuring Cinnamon $HEADER"

if ! gsettings list-children org.cinnamon &>/dev/null; then
    echo -e "$OK Cinnamon is not installed. Configuring not required."
    exit
fi


# ----- cinnamon

# Welcome Screen
gsettings set org.cinnamon.desktop.interface gtk-theme 'Mint-Y-Dark-Aqua'
gsettings set org.cinnamon.desktop.interface icon-theme 'Mint-Y-Dark-Aqua'

# Desktop
gsettings set org.nemo.desktop volumes-visible false

# Language
# todo !!!!

# Notifications
gsettings set org.cinnamon.desktop.notifications bottom-notifications true

# Screensaver
gsettings set org.cinnamon.desktop.session idle-delay 0

# Startup Applications
# todo !!!!

# Windows
gsettings set org.cinnamon.desktop.wm.preferences mouse-button-modifier '<Super>'
gsettings set org.cinnamon.desktop.wm.preferences action-scroll-titlebar 'shade'
gsettings set org.cinnamon alttab-switcher-style 'icons+preview'
gsettings set org.cinnamon alttab-minimized-aware true

# Mouse and Touchpad
gsettings set org.cinnamon.desktop.interface cursor-size 22
gsettings set org.cinnamon.desktop.peripherals.touchpad tap-to-click true

# Power Management
gsettings set org.cinnamon.settings-daemon.plugins.power sleep-display-ac 0
gsettings set org.cinnamon.settings-daemon.plugins.power sleep-display-ac 0
gsettings set org.cinnamon.settings-daemon.plugins.power sleep-inactive-ac-timeout 7200

# Screensaver
gsettings set org.cinnamon.desktop.screensaver allow-keyboard-shortcuts false
gsettings set org.cinnamon.desktop.screensaver allow-media-control false
gsettings set org.cinnamon.desktop.screensaver show-album-art false
gsettings set org.cinnamon.desktop.screensaver show-info-panel false
gsettings set org.cinnamon.desktop.screensaver floating-widgets false

# keybiard - layouts - allow different layout for individual windows
gsettings set org.gnome.libgnomekbd.desktop group-per-window true

echo -e "$OK DONE"