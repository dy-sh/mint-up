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

echo -e "$HEADER Installling Cinnamon applets $HEADER"

if ! gsettings list-children org.cinnamon &>/dev/null; then
    echo -e "$OK Cinnamon is not installed. Configuring not required."
    exit
fi

mkdir -p cinnamon/applets
cd cinnamon/applets


mapfile -t files < <(find . -name "*.zip")
for archive_name in "${files[@]}"; do
    applet="${archive_name%.zip}"
    if [[ -d "$HOME/.local/share/cinnamon/applets/$applet" ]]; then
        rm -r "$HOME/.local/share/cinnamon/applets/$applet"
    fi
    # 7z x "$applet.zip" -o"$HOME/.local/share/cinnamon/applets/"
    unzip -qq -o "$applet.zip" -d "$HOME/.local/share/cinnamon/applets/"

    if [[ -d "$HOME/.local/share/cinnamon/applets/$applet" ]]; then
        echo -e "$OK Installed: '$applet'"
    else
        echo -e "$ERR Failed to install '$applet'"
    fi
done



# cd ~/.local/share/cinnamon/applets/

echo -e "$OK DONE"