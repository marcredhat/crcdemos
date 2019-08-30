export DEMOUSER=user102
rm -rf tmp
mkdir tmp
cd tmp

git clone https://github.com/marcredhat/crcdemos.git
cd crcdemos/scripts
chmod +x *.sh
./prereqs.sh
./adduser.sh


su $DEMOUSER -c "cd /home/$DEMOUSER"
su $DEMOUSER -c "wget https://raw.githubusercontent.com/marcredhat/crcdemos/master/scripts/installgo.sh"

su $DEMOUSER -c "chmod +x *.sh"

su $DEMOUSER -c "./installgo.sh"
su $DEMOUSER -c "source /home/$DEMOUSER/.bashrc"
su $DEMOUSER -c "go"
