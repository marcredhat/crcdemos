export HOME=/home/demo

cd $HOME

wget https://dl.google.com/go/go1.12.9.linux-amd64.tar.gz

tar -xzf go1.12.9.linux-amd64.tar.gz

#Add to .bashrc:

echo "export GOROOT=$HOME/go" >> $HOME/.bashrc

echo "export GOPATH=$HOME/work" >> $HOME/.bashrc

echo "export PATH=$GOPATH/bin:$GOROOT/bin:$PATH"  >> $HOME/.bashrc

source .bashrc

go
