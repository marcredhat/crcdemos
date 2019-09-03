
oc delete project test-pipeline-demo
cd /root/podmancamelsap 
rm -rf openshift4gradle
git clone https://github.com/marcredhat/openshift4gradle.git
rm -rf createpipeline.sh
rm -rf rsync_to_container.sh
wget https://raw.githubusercontent.com/marcredhat/crcdemos/master/scripts/rsync_to_container.sh
wget https://raw.githubusercontent.com/marcredhat/crcdemos/master/scripts/createpipeline.sh
chmod +x *.sh
./createpipeline.sh
./rsync_to_container.sh
