oc project keptn
oc expose svc api-gateway-nginx
#we'll use the route we create by exposing the api-gateway-nginx service.

DT_TENANT=eye15053.live.dynatrace.com
DT_API_TOKEN=<Dynatrace API token>

KEPTN_API_TOKEN=$(kubectl get secret keptn-api-token -n keptn -ojsonpath={.data.keptn-api-token} | base64 --decode)
KEPTN_PROJECT=marc-crc-keptn-4

oc -n keptn create secret generic dynatrace --from-literal="DT_API_TOKEN=$DT_API_TOKEN" \
      --from-literal="DT_TENANT=$DT_TENANT" \
      --from-literal="KEPTN_API_URL=http://api-gateway-nginx-keptn.apps-crc.testing/api" \
      --from-literal="KEPTN_API_TOKEN=$KEPTN_API_TOKEN" -o yaml --dry-run=client | oc apply -f -
oc project dynatrace
kubectl apply -f https://raw.githubusercontent.com/keptn-contrib/dynatrace-service/0.8.0/deploy/service.yaml
keptn configure monitoring dynatrace --project=$KEPTN_PROJECT --service=carts --suppress-websocket
