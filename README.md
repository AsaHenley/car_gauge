A project that meant to be run on a raspberry pi.
It reads from a car's OBD port and publishes the data to a local webserver using the FastAPI python package.
A flutter project then reads this data and displays it to the screen.

The api server needs to be started using the fastapi dev obd_api.py command from ./car_gauge_api/
the server can be accessed at https://127.0.0.1:8000/ to check that it is running
