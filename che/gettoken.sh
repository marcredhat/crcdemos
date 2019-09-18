
#pip3 install yq httpie
export che_realm_endpoint="http://keycloak-che.apps-crc.testing/auth/realms/master/protocol/openid-connect/token"
subject_token=`oc whoami --show-token`


access_token=$(http --form POST $che_realm_endpoint grant_type='urn:ietf:params:oauth:grant-type:token-exchange' \
  client_id="che-public" \
  subject_token="$subject_token" subject_issuer='openshift-v4' \
  subject_token_type='urn:ietf:params:oauth:token-type:access_token' \
  | jq -r '.access_token')

  echo "Access Token: $access_token"
