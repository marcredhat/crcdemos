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

#get the latest CodeReady Containers version from https://github.com/code-ready/crc/branches
#export CRCVERSION=1.17.0
#export CRCMEM=128000
#export CRCCPUS=128



#test -z "$CRCVERSION" && CRCVERSION="1.17.0"
test -z "$CRCMEM" && CRCMEM="16000"
test -z "$CRCCPUS" && CRCCPUS="8"


#sudo yum -y install wget tar git podman buildah skopeo golang

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh


sudo rm -rf ./crc-macos-amd64.tar.xz
curl -L  https://mirror.openshift.com/pub/openshift-v4/clients/crc/latest/crc-macos-amd64.tar.xz -o crc-macos-amd64.tar.xz
tar -xvf crc-macos-amd64.tar.xz
#export PATH=$PATH:`pwd`/crc-macos-$CRCVERSION-amd64/
#sudo cp `pwd`/crc-linux-$CRCVERSION-amd64/crc /usr/local/bin
export CRCVERSION=$(ls -lat `pwd` | awk FNR==2' {print $0}' | awk -F " " '{print $NF}' | awk  -F "-" '{print $3}')
sudo cp `pwd`/crc-macos-$CRCVERSION-amd64/crc /usr/local/bin

crc config set memory $CRCMEM
crc config set cpus $CRCCPUS
crc setup
crc start --pull-secret-file pull-secret.txt
crc config get memory
crc config get cpus
eval $(crc oc-env)
oc version
crc console

#sudo cp /Users/<user>/.crc/bin/oc/oc /usr/local/bin
#sudo chmod +x /usr/local/bin/oc
