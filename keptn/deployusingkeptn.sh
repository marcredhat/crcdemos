GIT_TOKEN=<your git token>
KEPTN_ENDPOINT=http://api-gateway-nginx-keptn.apps-crc.testing/api
KEPTN_API_TOKEN=$(kubectl get secret keptn-api-token -n keptn -ojsonpath={.data.keptn-api-token} | base64 --decode)
echo $KEPTN_API_TOKEN
keptn auth --endpoint=$KEPTN_ENDPOINT --api-token=$KEPTN_API_TOKEN

#Create github repo and initialize with a README

#git clone https://github.com/keptn/examples.git

#cd examples/onboarding-carts/

keptn create project marc-crc-keptn-2 --shipyard ./shipyard.yaml --git-user=marcredhat --git-token=$GIT_TOKEN \
--git-remote-url=https://github.com/marcredhat/marc-crc-keptn-2.git --suppress-websocket

sleep 10

keptn onboard service carts --project=marc-crc-keptn-2 --chart=./carts

sleep 10

keptn send event new-artifact --project=marc-crc-keptn-2 --service=carts --image=docker.io/keptnexamples/carts --tag=0.11.2
