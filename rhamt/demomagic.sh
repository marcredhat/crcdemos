#!/usr/bin/env bash

########################
# include the magic
########################
. ../demo-magic.sh


########################
# Configure the options
########################

#
# speed at which to simulate typing. bigger num = faster
#
# TYPE_SPEED=20

#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#

# hide the evidence
clear



pe "export container=`sudo podman run -v /var/tmp/rhamt/:/home/rhamt:Z -it --detach --name=rhamtmarc  windup3/windup-cli-openshift sh -c 'while true ;do wait; done'`"
pe "export folderonhost=`sudo podman mount ${container}`"
pe "sudo mkdir ${folderonhost}/var/input"
pe "sudo cp /var/input/marc.ear ${folderonhost}/var/input"
pe "sudo rm -rf ${folderonhost}/home/rhamt"
pe "sudo mkdir ${folderonhost}/home/rhamt"
pe "sudo chmod a+rw -R ${folderonhost}/home/rhamt"
pe "sudo podman exec $container   /opt/migrationtoolkit/bin/rhamt-cli  --sourceMode --input /var/input/marc.ear --output /home/rhamt --target eap7"

# show a prompt so as not to reveal our true nature after
# the demo has concluded
p ""
