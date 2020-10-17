FROM jenkins/jenkins:latest

USER root

ARG ROOT_PASSWORD=root

RUN apt update && \
    apt install -y curl && \
    apt install -y openssh-server \
        apt-transport-https \
        ca-certificates \
        jq \
        gnupg2 \
        software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) \
       stable" && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /run/sshd

RUN echo "root:${ROOT_PASSWORD}" | chpasswd

COPY ./sshd_config /etc/ssh/

USER jenkins

ENV JBOSS_CLI /var/jenkins_home/wildfly-21.0.0.Final/bin/jboss-cli.sh
