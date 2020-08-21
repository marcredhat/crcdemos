eval $(crc oc-env)
oc new-project keptn
curl -sL https://get.keptn.sh | sudo -E bash
keptn install --use-case=continuous-delivery --platform=openshift

sleep 30 
oc get pvc

oc get pods

sleep 60

#for deploy in `oc get deploy -n keptn |awk '{ print $1 }'`
#do
#  oc set resources deployment $deploy  --limits=cpu=10m,memory=128Mi --requests=cpu=10m,memory=64Mi
#  oc delete pods --all -n keptn
#done

#expected result:
#oc get pods
#NAME                                                              READY   STATUS    RESTARTS   AGE
#api-gateway-nginx-5bc6f54d4b-8fqjt                                1/1     Running   0          52m
#api-service-55d4c499fd-zfslr                                      1/1     Running   0          52m
#bridge-559f9988c7-hkdfc                                           1/1     Running   0          52m
#configuration-service-865d89f78f-chnmp                            2/2     Running   2          52m
#eventbroker-go-dcf997974-55x4p                                    1/1     Running   0          52m
#gatekeeper-service-678f556955-6nhxd                               2/2     Running   2          52m
#helm-service-6946fb9b8d-tfjwr                                     2/2     Running   2          52m
#helm-service-continuous-deployment-distributor-567cc995bd-ksbtm   1/1     Running   4          52m
#jmeter-service-669848d4f8-h2nd4                                   2/2     Running   2          52m
#keptn-nats-cluster-0                                              3/3     Running   0          52m
#lighthouse-service-5bb8698f9-qrl9q                                2/2     Running   2          52m
#mongodb-datastore-cd457f886-pkhd6                                 2/2     Running   2          52m
#openshift-route-service-7f57d79955-jxbvp                          2/2     Running   2          52m
#remediation-service-5f44c6779c-m46wr                              2/2     Running   2          52m
#shipyard-service-6c989977d5-c6zjr                                 2/2     Running   2          52m
