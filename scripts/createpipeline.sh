oc new-project marc

# create service account

oc create serviceaccount pipeline
oc adm policy add-scc-to-user privileged -z pipeline
oc adm policy add-role-to-user edit -z pipeline

# create pipline tasks and resources

oc create -f tasks
oc create -f https://raw.githubusercontent.com/tektoncd/catalog/master/buildah/buildah.yaml
oc create -f https://raw.githubusercontent.com/tektoncd/catalog/master/openshift-client/openshift-client-task.yaml
oc create -f pipelines/mapit-resources.yml

oc apply -f apps/mapit-spring.yml
oc delete  -f pipelines/build-pipeline.yml
oc delete -f pipelines/mapit-build-pipeline-run.yml
oc delete -f pipelines/deploy-pipeline.yml
oc delete  -f pipelines/mapit-deploy-pipeline-run.yml


oc create -f pipelines/build-pipeline.yml
oc create -f pipelines/mapit-build-pipeline-run.yml
oc create -f pipelines/deploy-pipeline.yml
oc create -f pipelines/mapit-deploy-pipeline-run.yml
