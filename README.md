A program written in python and flutter meant to be used on a raspberry pi connected to a car's OBD port

python is used to read from the port using the OBD package and allows the data to be fetched through http requets to http://127.0.0.1:8000 using the fastapi package

Flutter then displays a variety of gauges on the screen to show the data by reading from the python server and decoding as a json

To start the python server {fastapi dev obd_api.py} needs to be run. Fastapi is installed using {pip install "fastapi[standard]"}
