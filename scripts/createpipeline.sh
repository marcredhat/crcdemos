oc project pipeline-demo
oc delete pods --all
oc apply -f apps/mapit-spring.yml
oc delete  -f pipelines/build-pipeline.yml
oc delete -f pipelines/mapit-build-pipeline-run.yml
oc delete -f pipelines/deploy-pipeline.yml
oc delete  -f pipelines/mapit-deploy-pipeline-run.yml


oc create -f pipelines/build-pipeline.yml
oc create -f pipelines/mapit-build-pipeline-run.yml
oc create -f pipelines/deploy-pipeline.yml
oc create -f pipelines/mapit-deploy-pipeline-run.yml
