#!/usr/bin/env bash
#

sudo apt update
sudo apt install git -y
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
ps aux | grep puma
