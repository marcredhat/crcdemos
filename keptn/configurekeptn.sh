oc expose svc api-gateway-nginx
#oc get route
#NAME                HOST/PORT                                  PATH   SERVICES            PORT   TERMINATION   WILDCARD
#api-gateway-nginx   api-gateway-nginx-keptn.apps-crc.testing          api-gateway-nginx   http                 None

export KEPTN_ENDPOINT=http://api-gateway-nginx-keptn.apps-crc.testing/api
export KEPTN_API_TOKEN=$(kubectl get secret keptn-api-token -n keptn -ojsonpath={.data.keptn-api-token} | base64 --decode)
echo $KEPTN_API_TOKEN

keptn auth --endpoint=$KEPTN_ENDPOINT --api-token=$KEPTN_API_TOKEN
#Starting to authenticate
#Successfully authenticated

keptn configure bridge --output

keptn configure bridge expose --user=marc --password=changeme
#Bridge credentials configured successfully

oc port-forward svc/bridge -n keptn 9000:8080
