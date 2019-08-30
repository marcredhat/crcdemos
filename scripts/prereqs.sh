su -c 'dnf -y install git wget tar qemu-kvm libvirt NetworkManager jq'

sudo systemctl start libvirtd

sudo systemctl enable libvirtd

#Install Python
#See https://developers.redhat.com/blog/2019/05/07/what-no-python-in-red-hat-enterprise-linux-8/

yum install @python36

yum install @python27

#When you install either (or both) you can easily make /usr/bin/python point to the right place using alternatives --config python

alternatives --config python
