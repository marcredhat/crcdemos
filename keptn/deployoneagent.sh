DT_TENANT=eye15053.live.dynatrace.com
DT_API_TOKEN=<Dynatrace API token>
DT_PAAS_TOKEN=<Dynatrace PAAS token>
oc -n dynatrace create secret generic oneagent \
--from-literal="apiToken=$DT_API_TOKEN" --from-literal="paasToken=$DT_PAAS_TOKEN"

oc new-project dynatrace

oc apply -f \
https://github.com/Dynatrace/dynatrace-oneagent-operator/releases/download/v0.8.0/openshift.yaml

#curl -o cr.yaml https://raw.githubusercontent.com/Dynatrace/dynatrace-oneagent-operator/master/deploy/cr.yaml
#Update cr.yaml with apiUrl and the name of secret we create above ("oneagent").
#In my case,
#apiUrl: https://eye15053.live.dynatrace.com/api
#tokens: "oneagent"
#If you want Dynatrace to monitor OpenShift Service Mesh deployments, set
#enableIstio: true


oc apply -f \
https://raw.githubusercontent.com/marcredhat/crcdemos/master/keptn/oneagentcr.yaml

#expected result:
#oc get pods -n dynatrace
#NAME                                          READY   STATUS    RESTARTS   AGE
#dynatrace-oneagent-operator-b6bf98cfd-58g8w   1/1     Running   0          14m
#dynatrace-oneagent-webhook-67b79d8b7f-lqcml   2/2     Running   0          14m
#oneagent-7smh6                                1/1     Running   0          11m
