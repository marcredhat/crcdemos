poddeploy=$(oc get pods | grep mapit-deploy-pipelinerun | cut -d " " -f 1)
echo $poddeploy
containersourcecopy=$(oc get pod ${poddeploy} -o jsonpath='{.spec.containers[*].name}'|  cut -d " " -f 5)
echo $containersourcecopy
oc rsync /root/podmancamelsap/podmancamelsap ${poddeploy}:/home/marc/sap -c $containersourcecopy
