#!/bin/bash
cd /home/ubuntu/my_flask_app
source venv/bin/activate
pip install -r requirements.txt
pkill gunicorn
nohup gunicorn -w 4 -b 0.0.0.0:5000 app:app &

