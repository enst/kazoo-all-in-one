#!/bin/bash

service crond restart
service bigcouch restart 
service rabbitmq-server restart 
sleep 5
service kz-whistle_apps restart 
service kz-ecallmgr restart 
service freeswitch restart
service kamailio restart
service httpd restart

exec /bin/bash
