FROM bingli/kazoo-installer
MAINTAINER Bing Li <enst.bupt@gmail.com>

RUN yum update -y
RUN yum install -y kazoo-bigcouch-R15B kazoo-R15B kazoo-kamailio kazoo-freeswitch-R15B \
                    kazoo-configs kazoo-prompts kazoo-librabbitmq \
                    monster-ui-accounts monster-ui-core monster-ui-numbers \
                    monster-ui-pbxs monster-ui-voip monster-ui-webhooks \
                    rsyslog httpd

WORKDIR /opt/kazoo_install

CMD ./setup_packages
