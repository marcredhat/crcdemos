#we'll use the route we create by exposing the api-gateway-nginx service.
KEPTN_API_TOKEN=$(kubectl get secret keptn-api-token -n keptn -ojsonpath={.data.keptn-api-token} | base64 --decode)I
DT_API_TOKEN=<Dynatrace API token>
KEPTN_PROJECT=marc-crc-keptn-4
oc -n keptn create secret generic dynatrace --from-literal="DT_API_TOKEN=<Dynatrace API token>" \
      --from-literal="DT_TENANT=eye15053.live.dynatrace.com" \
      --from-literal="KEPTN_API_URL=http://api-gateway-nginx-keptn.apps-crc.testing/api" \
      --from-literal="KEPTN_API_TOKEN=<Keptn API token>" -o yaml --dry-run=client | oc apply -f -
oc new-project dynatrace
kubectl apply -f https://raw.githubusercontent.com/keptn-contrib/dynatrace-service/0.8.0/deploy/service.yaml
keptn configure monitoring dynatrace --project=$KEPTN_PROJECT --service=carts --suppress-websocket
