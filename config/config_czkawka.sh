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

echo -e "$HEADER Configuring czkawka $HEADER"

echo -e "$INFO Instaliing shorturts"

# check if script running on linux mint
if [[ ! -f /etc/linuxmint/info ]]; then
    echo -e "$OK Not required on this distro"
    exit
fi

app_folder="/opt/czkawka"
if [[ -d "$app_folder" ]]; then
    echo -e "$INFO Instaliing czkawka shorturt"
    sudo rm -f /usr/share/applications/czkawka.desktop 

    echo "[Desktop Entry]
Version=1.0
Type=Application
Name=Czkawka
Exec="$app_folder/linux_czkawka_gui" %f
Comment=Duplicate finder
Categories=Accessories;
Terminal=false" | sudo tee --append /usr/share/applications/czkawka.desktop  > /dev/null
else
    echo -e "$NOTE czkawka is not installed. Skipping."
fi


app_folder="/opt/czkawka-cli"
if [[ -d "$app_folder" ]]; then
    echo -e "$INFO Instaliing czkawka-cli symlink"
    sudo rm -f /usr/local/bin/czkawka-cli
    sudo ln -s "$app_folder/linux_czkawka_cli" /usr/local/bin/czkawka-cli
else
    echo -e "$NOTE czkawka-cli is not installed. Skipping."
fi


echo -e "$OK DONE"



