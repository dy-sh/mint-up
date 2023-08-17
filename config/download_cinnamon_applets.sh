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


applets=(
batterymonitor@pdcurtis
batterypower@joka42
bluetooth-battery@zamszowy
cheaty@centurix
Cinnamenu@json
cinnamon-timer@jake1164
commandLauncher@scollins
cpu-monitor-text@gnemonix
cpufreq@mtwebster
ddcci-multi-monitor@tim-we
disk-read-and-write-speed@cardsurf
download-and-upload-speed@cardsurf
gmail@lauritsriple
gnote@brett-smith
gpaste-reloaded@feuerfuchs.eu
gputemperature@silentage.com
healthyeyes@ipolozov
hideable-applets@cardsurf
hwmonitor@sylfurd
ifstat@tagadan
internet-indicator@sangorys
ioDisk@ctrlesc
jenkins@backuity.org
kdecapplet@joejoetv
mailnagapplet@ozderya.net
mem-monitor-text@datanom.net
multicore-sys-monitor@ccadeptic23
netusagemonitor@pdcurtis
network@brownsr
nvidiaprime@pdcurtis
pa-equalizer@jschug.com
ptt@thbemme
radio@driglu4it
ScreenShot@tech71
ScreenShot+RecordDesktop@tech71
scripts@paucapo.com
Sensors@claudiux
SpicesUpdate@claudiux
ssm@Severga
sync@szlldm
sysmonitor@orcus
system-monitor@spacy01
systray-collapsible@koutch
temperature@fevimu
timeout@narutrey
todo@threefi
turn-off-monitor@zablotski
vnstat@linuxmint.com
weather@mockturtl
)

echo -e "$HEADER Downloading Cinnamon applets $HEADER"

if ! gsettings list-children org.cinnamon &>/dev/null; then
    echo -e "$OK Cinnamon is not installed. Configuring not required."
    exit
fi

# check internet connection
ping -c 1 www.google.com > /dev/null 
if [ ! $? -eq 0 ]; then
    echo -e "$ERR No internet connecion. Skipping."
    exit 1
fi

mkdir -p cinnamon/applets
cd cinnamon/applets

for applet in "${applets[@]}"; do
    if [[ -f "$applet.zip" ]]; then
        mv "$applet.zip" "$applet.backup.zip"
    fi

    wget -q --show-progress "https://cinnamon-spices.linuxmint.com/files/applets/$applet.zip"

    if [[ -f "$applet.zip" ]]; then
        rm -f "$applet.backup.zip"
    else
        echo -e "$ERR Failed to download '$applet'"
        rm -f "$applet.zip"
        if [[ -f "$applet.backup.zip" ]]; then
            mv "$applet.backup.zip" "$applet.zip"
        fi
    fi
done

echo -e "$OK DONE"
