

#https://github.com/marcredhat/crcdemos/tree/master/keptn

#https://haralduebele.blog/2019/09/17/openshift-service-mesh-aka-istio-on-codeready-containers/

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
oc new-project marc-bookinfo
git clone https://github.com/marcredhat/istio
#git clone https://github.com/istio/istio
cd istio/samples/bookinfo/platform/kube
oc project marc-bookinfo
oc create -f bookinfo.yaml

cd ../../networking
oc create -f bookinfo-gateway.yaml

oc create -f virtual-service-reviews-jason-v2-v3.yaml

export GATEWAY_URL=$(oc -n istio-system get route istio-ingressgateway -o jsonpath='{.spec.host}')
echo "GATEWAY_URL=$GATEWAY_URL"
GATEWAY_URL=istio-ingressgateway-istio-system.apps-crc.testing

sleep 5 

oc get pods -n marc-bookinfo
printf "\n\n => Browse to \n\n => http://istio-ingressgateway-istio-system.apps-crc.testing/productpage \n\n"
