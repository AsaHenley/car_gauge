A program written in python and flutter meant to be used on a raspberry pi connected to a car's OBD port

run {python -m vevn .venv} from the main project folder to create the virtual environment

For Windows {.venv\Scripts\activate}, For Linux {source .venv\Scripts\activate} to activate the venv, this needs to be done each time the venv is exited

After in the venv run {pip install requirements.txt} to get the necessary packages for fastapi

python is used to read from the port using the OBD package and allows the data to be fetched through http requets to http://127.0.0.1:8000 using the fastapi package

Flutter then displays a variety of gauges on the screen to show the data by reading from the python server and decoding as a json

To start the python server {fastapi run obd_api.py} needs to be run.