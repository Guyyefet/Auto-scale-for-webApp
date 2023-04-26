#!/bin/bash

sleep 30

sudo apt-get -y update
sudo apt-get -y upgrade 
# sudo apt-get update && apt-get upgrade python-pip

# mkdir flask-app
cd flask-app

# pip install --upgrade pip --user
sudo apt-get -y install python3.10-venv
python3 -m venv venv
source venv/bin/activate
# python3 -m pip install --upgrade pip

pip3.10 install -r requirements.text 
# python3 -m pip wheel install -r requirements.text
# venv/bin/pip3.10 install -r requirements.text

sudo mv /home/ubuntu/flask-app/app.service /etc/systemd/system/app.service
sudo systemctl enable app.service
sudo systemctl start app.service