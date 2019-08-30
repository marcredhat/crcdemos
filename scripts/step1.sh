
export DEMOUSER=demo14
git clone https://github.com/marcredhat/crcdemos.git
cd crcdemos/scripts
chmod +x ./*.sh

./prereqs.sh

./adduser.sh
su $DEMOUSER
cd /home/$DEMOUSER
sudo cp /root/crcdemos/scripts/installgo.sh /home/$DEMOUSER
sudo chmod +x ./*.sh
./installgo.sh
echo "export PATH=$HOME/work/bin:$HOME/go/bin:$PATH"  >> $HOME/.bashrc
source .bashrc


go
