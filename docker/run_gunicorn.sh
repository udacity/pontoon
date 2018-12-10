#!/bin/sh

echo "landing ssh config..."
mkdir /root/.ssh
chmod 700 /root/.ssh

# To preserve newlines, the env var is base64 encoded. Flip it back.
echo $SSH_KEY | base64 -d > /root/.ssh/id_rsa
chmod 400 /root/.ssh/id_rsa

ssh-keyscan -H github.com >> /root/.ssh/known_hosts

BIND="0.0.0.0:8000"
NWORKERS=4
TIMEOUT=30
/env/bin/gunicorn --bind $BIND --workers $NWORKERS --timeout $TIMEOUT pontoon.wsgi:application --log-file -
