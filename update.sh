#!/bin/bash

TEXT_RESET='\e[0m'
TEXT_YELLOW='\e[0;33m'
TEXT_RED_B='\e[1;31m'
echo -e $TEXT_RED_B
echo 'Aktueller Kernel...'
echo -e $TEXT_RESET

uname -a 
dpkg -l 'linux-[ihs]*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\([-0-9]*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | tee zu_entfernende_Kernel
cat zu_entfernende_Kernel | xargs sudo apt-get -y purge 
rm zu_entfernende_Kernel 

sudo apt-get update -y
echo -e $TEXT_YELLOW
echo 'APT update finished... NEXT apt list --upgradable'
echo -e $TEXT_RESET

sudo apt list --upgradable
echo -e $TEXT_YELLOW
echo '+++ WEITER?? +++ Taste drücken +++ NEXT apt-get upgrade -y'
echo -e $TEXT_RESET
read PAUSE

sudo apt-get upgrade -y
echo -e $TEXT_YELLOW
echo 'APT distributive upgrade finished... NEXT apt-get dist-upgrade -y'
echo -e $TEXT_RESET

sudo apt-get dist-upgrade -y
echo -e $TEXT_YELLOW
echo 'APT upgrade finished... NEXT apt-get autoremove -y'
echo -e $TEXT_RESET

sudo apt-get autoremove -y
echo -e $TEXT_YELLOW
echo 'APT auto remove finished...'
echo -e $TEXT_RESET

if [ -f /var/run/reboot-required ]; then
    echo -e $TEXT_RED_B
    echo 'Reboot required!'
    echo -e $TEXT_RESET
fi



echo "+++ ENDE +++ Taste drücken +++ ENDE +++ Taste drücken +++"
read PAUSE

