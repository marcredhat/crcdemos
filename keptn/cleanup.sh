crc delete
rm -rf istio
#oc delete project marc-bookinfo
#oc delete project istio-system
#rm -rf mesh1.sh
#rm -rf deploybookinfo.sh
curl -L https://raw.githubusercontent.com/marcredhat/crcdemos/master/keptn/deploybookinfo.sh -o deploybookinfo.sh
curl -L https://raw.githubusercontent.com/marcredhat/crcdemos/master/keptn/mesh1.sh -o mesh1.sh
sudo chmod +x ./deploybookinfo.sh
sudo chmod +x ./mesh1.sh
