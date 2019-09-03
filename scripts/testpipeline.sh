

#https://github.com/jenkins-x/jx/issues/3767
cd /root/podmancamelsap
rm -rf openshift4gradle
git clone https://github.com/marcredhat/openshift4gradle.git

cd openshift4gradle
rm -rf createpipeline.sh
rm -rf rsync_to_container.sh
wget https://raw.githubusercontent.com/marcredhat/crcdemos/master/scripts/rsync_to_container.sh
wget https://raw.githubusercontent.com/marcredhat/crcdemos/master/scripts/createpipeline.sh
chmod +x *.sh
#edit createpipeline.sh with new project name
./createpipeline.sh
./rsync_to_container.sh

#oc rsync /root/podmancamelsap/podmancamelsap pod/mapit-deploy-pipelinerun-bl7km-build-app-6lfrm-pod-b1cd7b:/workspace -c step-source-copy-mapit-git-rjtqk

#oc rsh -c step-source-copy-mapit-git-rjtqk  mapit-deploy-pipelinerun-bl7km-build-app-6lfrm-pod-b1cd7b 

#oc logs mapit-build-pipelinerun-ldpkg-build-app-5tgcq-pod-6f9228 -c step-build
