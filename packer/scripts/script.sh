#!/bin/bash

sleep 30

sudo apt-get -y update
sudo apt-get -y upgrade 

cd flask-app

sudo apt-get -y install python3.10-venv
python3 -m venv venv
source venv/bin/activate
pip3.10 install -r requirements.text 

sudo mv /home/ubuntu/flask-app/app.service /etc/systemd/system/app.service
sudo systemctl enable app.service
sudo systemctl start app.service