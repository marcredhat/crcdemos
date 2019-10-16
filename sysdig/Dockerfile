#git clone https://github.com/jenkinsci/sysdig-secure-plugin.git
FROM maven:3.3-jdk-8
# File Author / Maintainer
MAINTAINER Marc Chisinevski

# Copy inside the container
ADD . /usr/src/app

# Set the default directory where CMD will execute
WORKDIR /usr/src/app

# Set the default command to execute when creating a new container
CMD  mvn package

#sudo podman run --rm -it localhost/jenkinssysdig /bin/bash
