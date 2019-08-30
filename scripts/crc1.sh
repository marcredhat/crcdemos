export USER=demo3

su $USER

cd /home/$USER

git clone https://github.com/code-ready/crc.git

cd crc

make

#Set the memory available to CRC according to what you have on your physical server

#I’m on a physical server with around 40G of memory so I allocate 40G to CRC as follows:

crc config set memory 40000

crc setup
