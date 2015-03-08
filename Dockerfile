FROM bingli/kazoo-installer
MAINTAINER Bing Li <enst.bupt@gmail.com>

RUN yum update -y
RUN yum install -y kazoo-bigcouch-R15B kazoo-R15B kazoo-kamailio kazoo-freeswitch-R15B \
                    kazoo-prompts kazoo-librabbitmq kazoo-ui \
                    monster-ui-accounts monster-ui-core monster-ui-numbers \
                    monster-ui-pbxs monster-ui-voip monster-ui-webhooks \
                    rsyslog httpd

WORKDIR /opt/kazoo_install

CMD . ./setup_common \
                    && chown kazoo:daemon /opt/kazoo/log -R \
                    && sed -i '/port/s/15984/5984/' /etc/kazoo/config.ini \
                    && sed -i '/port/s/15986/5986/' /etc/kazoo/config.ini \
                    && confirm "Do you want to configure Kazoo now? [y|n]" && [[ $answer =~ ^[y|Y] ]] \
                    && yum reinstall -y kazoo-configs \
                    && echo "generrate erlang cookie" && generate_erlang_cookie \
                    && cp /etc/kazoo/erlang.cookie /opt/kazoo/.erlang.cookie \
                    && UUID=`cat /etc/kazoo/erlang.cookie` \
                    && sed -i '/cookie/s/change_me/'"${UUID}"'/' /etc/kazoo/config.ini
                    
