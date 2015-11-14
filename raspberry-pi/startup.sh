#!/bin/bash

# Start GPIO inputs
sudo /home/pi/installed/Adafruit-Retrogame/retrogame &

# Go to project
cd /home/pi/installed/determined-dill/;

# Check if internet is connected
wget -q --tries=10 --timeout=20 --spider http://google.com > /dev/null
if [[ $? -eq 0 ]]; then
  git pull origin master;
  npm install;
else
  echo "Offline";
fi

# Start HTTP server
forever start ./node_modules/http-server/bin/http-server $(pwd) -p 8080;
sleep 5;

# Start chromium
chromium --kiosk --ignore-certificate-errors --restore-last-session http://127.0.0.1:8080/;
