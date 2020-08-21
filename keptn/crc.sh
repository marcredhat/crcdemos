#!/bin/bash

set -e
START_TS=$(date +%s)
SINV="${0} ${@}"
SDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


err() {
    echo; echo;
    echo -e "\e[97m\e[101m[ERROR]\e[0m ${1}"; shift; echo;
    while [[ $# -gt 0 ]]; do echo "    $1"; shift; done
    echo; exit 1;
}

# Checking if we are root
#test "$(whoami)" = "root" || err "Not running as root"
export CRCVERSION=1.14.0
tar -xvzf crc-macos-amd64.tar.xz
#export PATH=$PATH:`pwd`/crc-macos-$CRCVERSION-amd64/
sudo cp `pwd`/crc-macos-$CRCVERSION-amd64/crc /usr/local/bin
crc config set memory 16000
crc setup
crc start --pull-secret-file pullsecret.txt
#eval $(crc oc-env)
#oc version
crc console
