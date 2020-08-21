GIT_TOKEN=<your git token>
KEPTN_PROJECT=marc-crc-keptn-3
KEPTN_ENDPOINT=http://api-gateway-nginx-keptn.apps-crc.testing/api
KEPTN_API_TOKEN=$(kubectl get secret keptn-api-token -n keptn -ojsonpath={.data.keptn-api-token} | base64 --decode)
echo $KEPTN_API_TOKEN
keptn auth --endpoint=$KEPTN_ENDPOINT --api-token=$KEPTN_API_TOKEN

keptn status
#expected result:
#Starting to authenticate
#Successfully authenticated
#CLI is authenticated against the Keptn cluster http://api-gateway-nginx-keptn.apps-crc.testing/api

#Create github repo and initialize with a README

#git clone https://github.com/keptn/examples.git

#cd examples/onboarding-carts/

keptn create project marc-crc-keptn-3 --shipyard ./shipyard.yaml --git-user=marcredhat --git-token=$GIT_TOKEN \
--git-remote-url=https://github.com/marcredhat/marc-crc-keptn-3.git
#expected result:
#https://github.com/marcredhat/marc-crc-keptn-3.git should have 4 branches as requested in the above shipyard.yaml
#Starting to create project
#ID of Keptn context: 9388cd2d-5d78-4c9a-9c78-c5ed293d9cce
#Project marc-crc-keptn-3 created
#Stage dev created
#Stage staging created
#Stage production created
#Shipyard successfully processed

sleep 10

keptn onboard service carts --project=marc-crc-keptn-3 --chart=./carts
#expected result:
#Starting to onboard service
#ID of Keptn context: 5fba67c2-776e-4dcb-bd4c-e4a30bb39052
#Create umbrella Helm Chart for project marc-crc-keptn-3
#Creating new Keptn service carts in stage dev
#Creating new Keptn service carts in stage staging
#Service already exists

sleep 10

keptn send event new-artifact --project=marc-crc-keptn-3 --service=carts --image=docker.io/keptnexamples/carts --tag=0.11.2
#expected result:
#Starting to send a new-artifact-event to deploy the service carts in project marc-crc-keptn-3 in version docker.io/keptnexamples/carts:0.11.2
#ID of Keptn context: f8bea429-3074-4a99-aeac-7999405ac84e
#Start updating chart carts of stage dev
#Finished updating chart carts of stage dev
#Start upgrading chart marc-crc-keptn-3-dev-carts in namespace marc-crc-keptn-3-dev
