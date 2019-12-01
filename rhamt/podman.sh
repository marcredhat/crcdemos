


[demouser@rhel8 ~]$ sudo podman run -v /var/tmp/rhamt/:/home/rhamt:Z -it --detach --name=rhamt1  windup3/windup-cli-openshift sh -c 'while true ;do wait; done'
a0ddb718078d7db5ed3d63e531a9d58711476f9b69680f4b570c14b8c3053707


[demouser@rhel8 ~]$ sudo podman mount a0ddb718078d7db5ed3d63e531a9d58711476f9b69680f4b570c14b8c3053707
/var/lib/containers/storage/overlay/afd9a1ac58525504dd837ddd42f365f56723c5dbaf5ab33dab7c8451900b44d8/merged


sudo mkdir /var/lib/containers/storage/overlay/afd9a1ac58525504dd837ddd42f365f56723c5dbaf5ab33dab7c8451900b44d8/merged/var/input
sudo cp /var/input/marc.ear /var/lib/containers/storage/overlay/afd9a1ac58525504dd837ddd42f365f56723c5dbaf5ab33dab7c8451900b44d8/merged/var/input


sudo podman exec a0ddb718078d7db5ed3d63e531a9d58711476f9b69680f4b570c14b8c3053707   /opt/migrationtoolkit/bin/rhamt-cli  --sourceMode --input /var/input/marc.ear --output /home/rhamt --target eap7


#sudo podman  run  -v /var/tmp/rhamt/:/home/rhamt:Z  -it windup3/windup-cli-openshift  /opt/migrationtoolkit/bin/rhamt-cli  --sourceMode --input /opt/migrationtoolkit/samples/jee-example-app-1.0.0.ear --output /home/rhamt --target eap7




#sudo podman run -it --detach --name=rhamt --net=host --security-opt label=disable --security-opt seccomp=unconfined --device /dev/fuse:rw -v /var/tmp/input/:/opt/migrationtoolkit/samples/:Z   windup3/windup-cli-openshift  sh -c 'while true ;do wait; done'

#sudo podman pod ps
#CONTAINER ID  IMAGE                                          COMMAND               CREATED         STATUS             PORTS  NAMES
#7f221aea1a82  docker.io/windup3/windup-cli-openshift:latest  sh -c while true ...  7 seconds ago   Up 7 seconds ago          rhamt
#96e0f3dee8b6  docker.io/windup3/windup-cli-openshift:latest  sh -c while true ...  13 minutes ago  Up 13 minutes ago         buildahctr

#sudo podman mount 7f221aea1a82
#/var/lib/containers/storage/overlay/655a9020f90ed3dd6f964d7bf0b9d3214d30027a595a38be7281191189d6814f/merged

#[demouser@rhel8 ~]$ sudo ls /var/lib/containers/storage/overlay/655a9020f90ed3dd6f964d7bf0b9d3214d30027a595a38be7281191189d6814f/merged/opt/migrationtoolkit/samples
#jee-example-app-1.0.0.ear


