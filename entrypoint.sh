#!/bin/bash

NOBODY_GROUP=$(id -g nobody)
NOBODY_USER=$(id -g nobody)

if [ -z "$PASSWORD" ] || [ "$PASSWORD" == "password" ] ; then
    PASSWORD="$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13 ; echo '')"
fi
PASSWORD_ENCODED="$(mkpasswd -m md5 <<< $PASSWORD)"

if [ "$1" = "start_proxy" ]; then
    cp 3proxy.cfg.dist 3proxy.cfg
    sed -i 's/__USER__/'"$USER"'/g' 3proxy.cfg && \
    sed -i 's#__PASSWORD__#'"$PASSWORD_ENCODED"'#g' 3proxy.cfg && \
    sed -i 's/__PORT__/'"$PORT"'/g' 3proxy.cfg && \
    sed -i 's/__DNS1__/'"$DNS1"'/g' 3proxy.cfg && \
    sed -i 's/__DNS2__/'"$DNS2"'/g' 3proxy.cfg && \
    sed -i 's/__NOBODY_GROUP__/'"$NOBODY_GROUP"'/g' 3proxy.cfg && \
    sed -i 's/__NOBODY_USER__/'"$NOBODY_USER"'/g' 3proxy.cfg
    echo "---------------------------------------------------------------------------------"
	echo "Proxy user login:         $USER"
	echo "Proxy user password:      $PASSWORD"
    echo "---------------------------------------------------------------------------------"
    3proxy /usr/local/etc/3proxy/3proxy.cfg
else
	exec "$@"
fi
