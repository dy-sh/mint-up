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

echo -e "$HEADER Configuring git $HEADER"

# ----- git config
echo -e "$INFO Configuring commit message..."
echo -e "$NOTE Current git user name: $(git config --global user.name)"
echo -e "$NOTE Current git email    : $(git config --global user.email)"
read -rep "$ACTN Enter new user name (leave empty for skip): " git_username
read -rep "$ACTN Enter new email     (leave empty for skip): " git_email
if [[ -n "$git_username" ]]; then
    git config --global user.name "$git_username"
    echo -e "$OK User name changed"
else
    echo -e "$INFO User name not changed"
fi
if [[ -n "$git_email" ]]; then
    git config --global user.email "$git_email"
    echo -e "$OK Email changed"
else
    echo -e "$INFO Email not changed"
fi    
echo -e "$OK Commit message configured"

if ! command -v gh &> /dev/null; then
    echo "$INFO Installing github-cli"
    type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y
fi


echo "$ACTN Authorizing. Press Ctrl+C if not required."

if gh auth login; then
    echo -e "$OK DONE"
fi


# ############################# OLD #####################

# #  ----- git download and compile libsecret
# # sudo apt install libsecret-1-0 libsecret-1-dev gcc make
# sudo make --directory=/usr/share/doc/git/contrib/credential/libsecret
# git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret

# # ----- git authorization
# echo Create Git Personal Access Token and copy to clipboard
# echo -e "$INFO Then print git username (email) and access token instead of password below if git asked"
# xdg-open "https://github.com/settings/tokens/new" &> /dev/null
# if git clone "https://github.com/USERNAME/empty-private-repo" ~/Downloads/temp_git_repo; then
#     rm -r ~/Downloads/temp_git_repo
#     echo -e "$OK DONE"
# else
#     echo -e "${RED} Failed to clone git testing repo ${NC}"
# fi
