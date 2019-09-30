FROM registry.access.redhat.com/ubi8/ubi:latest

# File Author / Maintainer
MAINTAINER Marc Chisinevski

RUN dnf -y install --nodocs tar gzip binutils* file  libaio* libpam* && dnf clean all

RUN curl -o /tmp/client.tar.gz -SL \
    https://<.......>ibm_data_server_client_linuxx64_v11.5.tar.gz?dl=1 \
    --retry 2 --retry-max-time 0 -C - && \
    tar xvfz /tmp/client.tar.gz -C /usr/bin && \
    rm -f /tmp/client.tar.gz


RUN rpm -ivh https://www.rpmfind.net/linux/fedora/linux/releases/30/Everything/x86_64/os/Packages/n/numactl-libs-2.0.12-2.fc30.x86_64.rpm

WORKDIR /usr/bin/client
