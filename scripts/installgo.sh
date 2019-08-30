export HOME=/home/$DEMOUSER

cd $DEMOUSER

wget https://dl.google.com/go/go1.12.9.linux-amd64.tar.gz

tar -xzf go1.12.9.linux-amd64.tar.gz

#Add to .bashrc:

echo "export GOROOT=$HOME/go" >> $HOME/.bashrc

echo "export GOPATH=$HOME/work" >> $HOME/.bashrc

echo "export PATH=$HOME/work/bin:$HOME/go/bin:$PATH"  >> $HOME/.bashrc

source .bashrc

su $DEMOUSER

go
