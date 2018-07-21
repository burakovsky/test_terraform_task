#!/bin/bash -v
apt-get update -y
apt-get install -y nginx > /tmp/nginx.log
echo "<html>$HOSTNAME</html>" > /var/www/html/index.html