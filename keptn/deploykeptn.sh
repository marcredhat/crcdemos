eval $(crc oc-env)
oc new-project keptn
curl -sL https://get.keptn.sh | sudo -E bash
keptn install --use-case=continuous-delivery --platform=openshift

sleep 30 
oc get pvc

oc get pods
