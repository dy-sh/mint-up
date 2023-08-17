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

echo -e "$HEADER Configuring Steam $HEADER"

# check if script running on linux mint
if [[ ! -f /etc/linuxmint/info ]]; then
    echo -e "$OK Not required on this distro"
    exit
fi

echo -e "$INFO Editing steam.desktop file for change app scale..."

desktop_file="/usr/share/applications/steam.desktop"

# Check if the .desktop file exists
if [[ ! -f "$desktop_file" ]]; then
    echo -e "$NOTE Steam is not installed. Skipping."
    exit
fi

additional_text="env GDK_SCALE=2 "

exec_lines=$(grep -E "^Exec=" "$desktop_file")

# Check if any lines are found
if [ -n "$exec_lines" ]; then

    # Process each line
    while IFS= read -r exec_line; do

        # Split the line at the first "=" character
        exec_key="${exec_line%%=*}"
        exec_value="${exec_line#*=}"

        # Check if the line was successfully split
        if [ -n "$exec_key" ] && [ -n "$exec_value" ]; then

            # Check if the line already contains the additional text
            if [[ ! "$exec_value" =~ "$additional_text" ]]; then

                # Combine the key, additional text, and the value
                new_exec_line="$exec_key=$additional_text$exec_value"

                # Replace the line in the .desktop file
                sudo sed -i "s~$exec_line~$new_exec_line~" "$desktop_file"
            else
                echo -e "$NOTE Skipped line (already edited): $exec_line"
            fi
        else
            echo -e "$ERR Failed to split the line into key and value: $exec_line"
        fi
    done <<< "$exec_lines"

    echo -e "$OK Editing lines is completed"
else
    echo -e "$ERR No lines starting with 'Exec=' found."
fi

echo -e "$OK DONE"