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

echo -e "$HEADER Configuring Geekbench $HEADER"

echo -e "$INFO Installling Geekbench symlinks"

# check if script running on linux mint
if [[ ! -f /etc/linuxmint/info ]]; then
    echo -e "$OK Not required on this distro"
    exit
fi

if command -v geekbench || command -v geekbench5 || command -v geekbench4 &> /dev/null; then
    echo Geekbench already configured. Skip.
    exit
fi


if [[ -f "/opt/Geekbench5/geekbench5" ]]; then
    sudo rm -f /usr/local/bin/geekbench5
    sudo ln -s /opt/Geekbench5/geekbench5 /usr/local/bin/geekbench5
    echo Geekbench5 installed.
else
    echo -e "\n${YELLOW} Geekbench5 is not installed! Skipping! ${NC}\n"
fi


if [[ -f "/opt/Geekbench6/geekbench6" ]]; then
    sudo rm -f /usr/local/bin/geekbench6 
    sudo rm -f /usr/local/bin/geekbench

    sudo ln -s /opt/Geekbench6/geekbench6 /usr/local/bin/geekbench6
    sudo ln -s /opt/Geekbench6/geekbench6 /usr/local/bin/geekbench
    echo Geekbench6 installed.
else
    echo -e "\n${YELLOW} Geekbench6 is not installed! Skipping! ${NC}\n"
fi


echo -e "$OK DONE"