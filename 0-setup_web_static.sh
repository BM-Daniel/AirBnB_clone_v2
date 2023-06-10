#!/usr/bin/env bash
## sets up my web servers for the deployment of web_static

sudo apt update
sudo apt -y install nginx

mkdir -p /data/web_static/releases/test/
mkdir -p /data/web_static/shared/

echo "<h1>Welcome to Danzzy Tech World</h1>" > /data/web_static/releases/test/index.html

ln -sf /data/web_static/releases/test/ /data/web_static/current/

chown -R ubuntu /data/
chgrp -R ubuntu /data/

printf %s "server {
    listen 80 default_server;
    listen [::]:80 default_server;

    add_header X-Served-By $HOSTNAME;

    root /var/www/html;
    index index.html index.htm;

    location /hbnb_static {
        alias /data/web_static/current;
        index index.html index.htm;
    }

    
}" > /etc/nginx/sites-available/default

ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

service nginx restart

echo -e "\nCOMPLETE\n"
