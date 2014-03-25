#!/bin/bash
set -e 
cd /var/tmp/ansible-redis
/usr/bin/ansible-playbook ./site.yml -c local
