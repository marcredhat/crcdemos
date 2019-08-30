export DEMOUSER=user102
rm -rf tmp
mkdir tmp
cd tmp

git clone https://github.com/marcredhat/crcdemos.git
cd crcdemos/scripts
chmod +x *.sh
./prereqs.sh
./adduser.sh

su $DEMOUSER
cd /home/$DEMOUSER
git clone https://github.com/marcredhat/crcdemos.git
cd crcdemos/scripts
chmod +x *.sh

cd /home/$DEMOUSER
wget https://raw.githubusercontent.com/marcredhat/crcdemos/master/scripts/installgo.sh
source /home/$DEMOUSER/.bashrc
go
