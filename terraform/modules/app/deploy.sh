#!/bin/bash
set -e
APP_DIR=${2:-$HOME}
sudo pkill -9 apt
sudo apt-get install -y git --allow-unauthenticated
git clone -b monolith https://github.com/express42/reddit.git $APP_DIR/reddit
cd $APP_DIR/reddit
echo "DATABASE_URL=$1:27017" > ./puma-environment
bundle install
sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma
