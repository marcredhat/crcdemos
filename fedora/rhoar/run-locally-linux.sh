#!/usr/bin/env bash

# Uncomment for debugging
#set -x
#set -e

# if [[ "${RED_HAT_DEVELOPERS_USERNAME}X" == "X" || "${RED_HAT_DEVELOPERS_PASSWORD}X" == "X" ]]; then
#     printf 'An account on https://developers.redhat.com is required to use this environment. Please enter your credentials here:\n\n'
#     printf 'Enter your Red Hat Developers Username: '
#     read -s RED_HAT_DEVELOPERS_USERNAME
#     echo
#     printf 'Enter your Red Hat Developers Password: '
#     read -s RED_HAT_DEVELOPERS_PASSWORD
#     echo
# else
#     echo "Red Hat Developers credentials found in environment variables."
# fi

DOCKER_CMD_PREFIX=""

oc
OC_CMD_STATUS=$?

if [[ $OC_CMD_STATUS -eq 0 ]]; then
    echo "OpenShift CLI tool installed and accessbile"
else
    echo "You need to install the OpenShift CLI tool from https://github.com/openshift/origin/releases"
    exit 2
fi

ansible --version | grep "^ansible 2\.[5678].*"
ANSIBLE_STATUS=$?

if [[ $ANSIBLE_STATUS -eq 0 ]]; then
    echo "Ansible version is acceptable"
else
    echo "Ansible is either missing or too old. Attempting to use containerized Ansible."
    docker ps
    DOCKER_STATUS=$?
    if [[ $DOCKER_STATUS -eq 0 ]]; then
        DOCKER_CMD_PREFIX="docker run -v $HOME/.kube/config:/openshift-applier/.kube/config:z -w /tmp/my-inventory -u root -v $PWD:/tmp/my-inventory -e INVENTORY_PATH=/tmp/my-inventory -t redhatcop/openshift-applier"
    else
        echo "Ansible version missing/unacceptable, and containerized Ansible is not possible. If you are running on Windows, try installing the Windows Subsystem For Linux (WSL) from the store and try from the Bash terminal there."
        echo 1
    fi
fi

oc cluster-info | grep "not running"
CRC_RUNNING=$?

#if [[ $CRC_RUNNING -eq 0 ]]; then
#    oc cluster up --host-data-dir=/var/lib/origin/openshift.local.data --image-streams=rhel7 --service-catalog=true --use-existing-config=true
#    oc delete project myproject
#else
#    echo "CRC is already running"
#fi

oc login -u kubeadmin
oc import-image redhat-openjdk18-openshift:1.1 --from=registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift --confirm

#oc login -u developer -p developer --insecure-skip-tls-verify=true

${DOCKER_CMD_PREFIX} ansible-galaxy install -r requirements.yml --roles-path=roles

${DOCKER_CMD_PREFIX} ansible-playbook apply.yml -i inventory/ -e target=bootstrap

oc project labs-ci-cd


${DOCKER_CMD_PREFIX} ansible-playbook apply.yml -i inventory/ -e target=tools

${DOCKER_CMD_PREFIX} ansible-playbook apply.yml -i inventory/ -e target=apps
