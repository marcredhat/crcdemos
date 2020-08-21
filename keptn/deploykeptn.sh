eval $(crc oc-env)
oc new-project keptn
curl -sL https://get.keptn.sh | sudo -E bash
keptn install --use-case=continuous-delivery --platform=openshift

sleep 30 
oc get pvc

oc get pods

sleep 60

for deploy in `oc get deploy -n keptn |awk '{ print $1 }'`
do
  oc set resources deployment $deploy  --limits=cpu=10m,memory=128Mi --requests=cpu=10m,memory=64Mi
  oc delete pods --all -n keptn
done
