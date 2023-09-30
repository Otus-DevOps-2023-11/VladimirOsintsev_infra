#!/usr/bin/env bash

#while [ ! -s "/var/lib/dpkg/lock-frontend" ] ; do sleep 5 ; done
#apt update
apt-get update
apt install -y ruby-full ruby-bundler build-essential
