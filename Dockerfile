FROM registry.redhat.io/redhat-openjdk-18/openjdk18-openshift:1.12-1.1652304483

USER root

ADD ./mongodb-mms-automation-agent-11.11.0.7355-1.rhel7_x86_64.tar.gz /opt

COPY ./rpm /opt/rpm

WORKDIR /opt/rpm

RUN yum localinstall ./*.rpm -y 

WORKDIR /opt/mongodb-mms-automation-agent-11.11.0.7355-1.rhel7_x86_64

COPY ./local.config /opt/mongodb-mms-automation-agent-11.11.0.7355-1.rhel7_x86_64

RUN mkdir -m 755 -p /var/lib/mongodb-mms-automation

RUN mkdir -m 755 -p /var/log/mongodb-mms-automation

RUN mkdir -m 755 -p /data

RUN mkdir -m 755 -p /mongodb/db

RUN touch /var/log/mongodb-mms-automation/automation-agent-fatal.log

RUN chmod 755 /var/log/mongodb-mms-automation/automation-agent-fatal.log

RUN useradd -u 1501 mongod

RUN chown 1501:1501 /var/lib/mongodb-mms-automation

RUN chown 1501:1501 /var/log/mongodb-mms-automation

RUN chown 1501:1501 /data

RUN chown -R 1501:1501 /mongodb/db

RUN chown 1501:1501 /mongodb

RUN chown 1501:root /var/log/mongodb-mms-automation/automation-agent-fatal.log

RUN chmod -R g+rwX /var/log/mongodb-mms-automation

RUN chmod -R g+rwX /var/lib/mongodb-mms-automation

USER 185

CMD [ "/bin/sh" , "-c" , "/opt/mongodb-mms-automation-agent-11.11.0.7355-1.rhel7_x86_64/mongodb-mms-automation-agent --config=/opt/mongodb-mms-automation-agent-11.11.0.7355-1.rhel7_x86_64/local.config >> /var/log/mongodb-mms-automation/automation-agent-fatal.log 2>&1" ]


