#!/bin/sh

echo "Injecting env vars ..."
sed -i 's@!!!CLIENT_LOGO_URL!!!@'"$CLIENT_LOGO_URL"'@' /usr/share/nginx/html/index.html
sed -i 's@!!!CLIENT_NAME!!!@'"$CLIENT_NAME"'@' /usr/share/nginx/html/index.html

echo "Starting Nginx ..."
nginx -g 'daemon off;'