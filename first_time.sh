#!/bin/bash

source ./setup_common 

confirm 'Would you like to (re)configure Kazoo now? [y|n]'
[[ $answer =~ ^[y|Y] ]] || exit 0

#yum reinstall -y kazoo-configs
#chown kazoo:daemon /opt/kazoo/log -R 

cd /etc
rm kazoo -rf
cp -r kazoo.orig kazoo

sed -i '/port/s/15984/5984/' /etc/kazoo/config.ini 
sed -i '/port/s/15986/5986/' /etc/kazoo/config.ini 
sed -i '/children/s/25/10/' /etc/kazoo/kamailio/default.cfg 

echo "generrate erlang cookie" && generate_erlang_cookie 
rm -rf /opt/kazoo/.erlang.cookie && ln -s /etc/kazoo/erlang.cookie /opt/kazoo/.erlang.cookie 
rm -rf /var/lib/rabbitmq/.erlang.cookie && ln -s /etc/kazoo/erlang.cookie /var/lib/rabbitmq/.erlang.cookie
UUID=`cat /etc/kazoo/erlang.cookie` 
sed -i '/cookie/s/= .*/= '"${UUID}"'/' /etc/kazoo/config.ini 

#confirm "Would you like to start services? [y|n]" 
#[[ $answer =~ ^[y|Y] ]] || exit 0
#service bigcouch restart 
#service rabbitmq-server restart 
#sleep 5 && service kz-whistle_apps restart 
#service kz-ecallmgr restart 
#/opt/kazoo/utils/media_importer/media_importer -h localhost -P 5984 /opt/kazoo/system_media/*.wav 
#sup -t 3600 whapps_maintenance migrate 
#sup -n ecallmgr ecallmgr_maintenance add_fs_node freeswitch@${HOSTNAME} 

