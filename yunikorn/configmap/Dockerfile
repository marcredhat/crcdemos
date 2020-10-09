#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#FROM golang:1.12.13-alpine3.10
FROM ubi8/s2i-base

ENV NAME=golang \
    VERSION=1.13.15 \
    CONTAINER_NAME="rhel8/go-toolset"
 
ENV SUMMARY="Platform for building and running Go Applications" \
    DESCRIPTION="Go Toolset available as a container is a base platform for \
building and running various Go applications and frameworks. \
Go is an easy to learn, powerful, statically typed language in the C/C++ \
tradition with garbage collection, concurrent programming support, and memory safety features."

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Go $VERSION" \
      io.openshift.tags="builder,golang,golang113,rh-golang113,go" \
      com.redhat.component="go-toolset-container" \
      com.redhat.license_terms="https://www.redhat.com/en/about/red-hat-end-user-license-agreements#UBI" \
      name="$CONTAINER_NAME" \
      version="$VERSION"

RUN INSTALL_PKGS="go-toolset" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y

# Copy the S2I scripts from the specific language image to $STI_SCRIPTS_PATH.
#COPY ./s2i/bin/ $STI_SCRIPTS_PATH

#COPY ./root/ /

#RUN chown -R 1001:0 $STI_SCRIPTS_PATH && chown -R 1001:0 $APP_ROOT

#USER 1001

# Set the default CMD to print the usage of the language image.
#CMD $STI_SCRIPTS_PATH/usage

# admission controller bundles
RUN dnf -y install curl
RUN  dnf -y install jq
RUN dnf -y update openssl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.15.12/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl
COPY admission-controller-init-scripts/admission_util.sh /
COPY admission-controller-init-scripts/configs.properties /
COPY admission-controller-init-scripts/generate-signed-ca.sh /
COPY admission-controller-init-scripts/templates /templates
RUN chmod +x /admission_util.sh
RUN chmod +x /generate-signed-ca.sh

# scheduler binary
ADD k8s_yunikorn_scheduler /k8s_yunikorn_scheduler
WORKDIR /
ENV CLUSTER_ID "mycluster"
ENV CLUSTER_VERSION "latest"
ENV POLICY_GROUP "queues"
ENV SCHEDULING_INTERVAL "1s"
ENV LOG_LEVEL "0"
ENV LOG_ENCODING "console"
ENV VOLUME_BINDING_TIMEOUT "10s"
ENV EVENT_CHANNEL_CAPACITY "1048576"
ENV DISPATCHER_TIMEOUT "300s"
ENV KUBE_CLIENT_QPS "1000"
ENV KUBE_CLIENT_BURST "1000"
ENV PREDICATES ""
ENV OPERATOR_PLUGINS "general"
ENV ENABLE_CONFIG_HOT_REFRESH "true"
ENTRYPOINT ["sh", "-c", "/k8s_yunikorn_scheduler \
-clusterId=${CLUSTER_ID} \
-clusterVersion=${CLUSTER_VERSION} \
-policyGroup=${POLICY_GROUP} \
-interval=${SCHEDULING_INTERVAL} \
-logLevel=${LOG_LEVEL} \
-logEncoding=${LOG_ENCODING} \
-volumeBindTimeout=${VOLUME_BINDING_TIMEOUT} \
-eventChannelCapacity=${EVENT_CHANNEL_CAPACITY} \
-dispatchTimeout=${DISPATCHER_TIMEOUT} \
-kubeQPS=${KUBE_CLIENT_QPS} \
-kubeBurst=${KUBE_CLIENT_BURST} \
-predicates=${PREDICATES} \
-operatorPlugins=${OPERATOR_PLUGINS} \
-enableConfigHotRefresh=${ENABLE_CONFIG_HOT_REFRESH}"]
