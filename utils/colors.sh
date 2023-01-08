### Color Functions ##
#!/usr/bin/env bash

### Colors ##
ESC=$(printf '\033')
RESET="${ESC}[0m"
BLACK="${ESC}[30m"
RED="${ESC}[31m"
GREEN="${ESC}[32m"
YELLOW="${ESC}[33m"
BLUE="${ESC}[34m"
MAGENTA="${ESC}[35m"
CYAN="${ESC}[36m"
WHITE="${ESC}[37m"
DEFAULT="${ESC}[39m"
export noir='\e[0;30m'
export gris='\e[1;30m'
export rougefonce='\e[1;31m'
export rouge='\e[0;31m'
export rose='\e[1;31m'
export vertfonce='\e[0;32m'
export vertclair='\e[1;32m'
export orange='\e[0;33m'
export jaune='\e[1;33m'
export bleufonce='\e[0;34m'
export bleuclair='\e[1;34m'
export violetfonce='\e[0;35m'
export violetclair='\e[1;35m'
export cyanfonce='\e[0;36m'
export cyanclair='\e[1;36m'
export grisclair='\e[0;37m'
export blanc='\e[1;37m'
export neutre='\e[0;m'

greenprint() { printf "${GREEN}%s${RESET}\n" "$1"; }
blueprint() { printf "${BLUE}%s${RESET}\n" "$1"; }
redprint() { printf "${RED}%s${RESET}\n" "$1"; }
yellowprint() { printf "${YELLOW}%s${RESET}\n" "$1"; }
magentaprint() { printf "${MAGENTA}%s${RESET}\n" "$1"; }
cyanprint() { printf "${CYAN}%s${RESET}\n" "$1"; }
fn_goodafternoon() { echo; echo "Good afternoon."; }
fn_goodmorning() { echo; echo "Good morning."; }
fn_bye() { echo "Bye bye."; exit 0; }
fn_fail() { echo "Wrong option." exit 1; }