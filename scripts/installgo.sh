cd /home/marc

wget https://dl.google.com/go/go1.12.9.linux-amd64.tar.gz

tar -xzf go1.12.9.linux-amd64.tar.gz

#Add to .bashrc:

echo "export GOROOT=/home/marc/go" >> .bashrc

echo "export GOPATH=/home/marc/work" >> .bashrc

export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

source .bashrc
