#!/bin/bash

export HOST_ADDRESS=`hostname -I | sed 's/^[[:space:]]*//g'`
cat /etc/keystone/keystone.conf.j2 | python -c 'import os;import sys; import jinja2; sys.stdout.write(jinja2.Template(sys.stdin.read()).render(env=os.environ))' > /etc/keystone/keystone.conf

cat /openrc.j2 | python -c 'import os;import sys; import jinja2; sys.stdout.write(jinja2.Template(sys.stdin.read()).render(env=os.environ))' > /openrc

echo "ServerName $HOST_ADDRESS" >> /etc/apache2/apache2.conf

a2ensite keystone
apache2ctl -D FOREGROUND
