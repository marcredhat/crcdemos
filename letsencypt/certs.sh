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
#DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "

# hide the evidence
clear



p "Get and install Let's Encrypt certs for OpenShift 4.2/CRC"
p "I'm using a GoDaddy domain (marcredhat.com) so I exported GD_Secret and GD_Key from https://developer.godaddy.com/keys/"
p "Generate cert for my app (nginx.marcredhat.com)"
pe  "${HOME}/acme.sh/acme.sh --issue -d marcredhat.com -d nginx.marcredhat.com  --dns dns_gd"
pe "oc describe route nginx.marcredhat.com"
p "Check that nginx.marcredhat.com points to my OpenShift 4.2 router"
pe "ping -c 1 nginx.marcredhat.com"
#pe "oc delete secret  router-certs -n openshift-ingress"
pe "oc create secret tls router-certs --cert=/home/demouser/.acme.sh/marcredhat.com/fullchain.cer --key=/home/demouser/.acme.sh/marcredhat.com/marcredhat.com.key -n openshift-ingress"
pe "oc patch ingresscontroller default -n openshift-ingress-operator --type=merge --patch='{\"spec\": { \"defaultCertificate\": { \"name\": \"router-certs\" }}}'"
# show a prompt so as not to reveal our true nature after
# the demo has concluded
p ""
