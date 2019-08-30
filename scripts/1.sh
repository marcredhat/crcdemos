export DEMOUSER=user102
rm -rf tmp
mkdir tmp
cd tmp

git clone https://github.com/marcredhat/crcdemos.git
cd crcdemos/scripts
chmod +x *.sh
./prereqs.sh
./adduser.sh


