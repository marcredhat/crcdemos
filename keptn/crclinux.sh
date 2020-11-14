#!/bin/bash
#run this script from an empty directory
#before you run, configure pull secret and default values as shown below
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


#copy the pull secret from https://cloud.redhat.com/openshift/install/pull-secret to ./pull-secret

#get the latest CodeReady Containers version from https://github.com/code-ready/crc/branches

sudo rm -rf ./crc-linux-amd64.tar.xz
wget https://mirror.openshift.com/pub/openshift-v4/clients/crc/latest/crc-linux-amd64.tar.xz
tar -xvf crc-linux-amd64.tar.xz
export CRCVERSION=$(ls -latr `pwd` | awk FNR==2' {print $0}' | awk -F " " '{print $NF}' | awk  -F "-" '{print $3}')
sudo cp `pwd`/crc-linux-$CRCVERSION-amd64/crc /usr/bin


#or configure a specific CodeReady Containers versions as shown below
#export CRCVERSION=1.17.0

#configure the memory and cores that CodeReady Containers can use
#export CRCMEM=128000
#export CRCCPUS=128

#or use the minimum possible values (configured as default values below)
#test -z "$CRCVERSION" && CRCVERSION="1.17.0"
test -z "$CRCMEM" && CRCMEM="16000"
test -z "$CRCCPUS" && CRCCPUS="8"


sudo yum -y install wget tar git podman buildah skopeo golang

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
sudo chmod 700 get_helm.sh
./get_helm.sh
sudo cp /usr/local/bin/helm /usr/bin



crc config set memory $CRCMEM
crc config set cpus $CRCCPUS
crc setup
crc start --pull-secret-file ./pull-secret
crc config get memory
crc config get cpus
eval $(crc oc-env)
oc version
crc console

