
su $DEMOUSER 
cd /home/$DEMOUSER
wget https://raw.githubusercontent.com/marcredhat/crcdemos/master/scripts/installgo.sh

chmod +x *.sh

./installgo.sh
source /home/$DEMOUSER/.bashrc

go
