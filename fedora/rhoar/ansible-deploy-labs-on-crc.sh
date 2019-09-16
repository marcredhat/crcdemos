#!/usr/bin/env bash

# Uncomment for debugging
#set -x
#set -e


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
fi

oc cluster-info | grep "not running"
CRC_RUNNING=$?


oc login -u kubeadmin
oc import-image redhat-openjdk18-openshift:1.1 --from=registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift --confirm

ansible-galaxy install -r requirements.yml --roles-path=roles

ansible-playbook apply.yml -i inventory/ -e target=bootstrap

oc project labs-ci-cd

ansible-playbook apply.yml -i inventory/ -e target=tools

ansible-playbook apply.yml -i inventory/ -e target=apps
