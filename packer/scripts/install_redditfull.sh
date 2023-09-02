#!/usr/bin/env bash

apt-get update -y && \
apt-get install -y git
mkdir /opt/puma && \
cd /opt/puma && \
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
cat > /etc/systemd/system/puma.service << EOF
[Unit]
Description=Puma
After=network.target

[Service]
Type=simple
WorkingDirectory=/opt/puma/reddit
ExecStart=/usr/local/bin/puma
ExecReload=/bin/kill -s HUP $MAINPID
ExecStop=/bin/kill -s QUIT $MAINPID

[Install]
WantedBy=multi-user.target
EOF
chmod 664 /etc/systemd/system/puma.service
systemctl daemon-reload && systemctl enable puma && systemctl start puma
