from fastapi import FastAPI
import time
import obd
import random

app = FastAPI()
connection = obd.OBD()
start_time = time.time()

@app.get("/") # http://127.0.0.1:8000/
def read_root():
    return getObdData()


def getObdData():
    # Read obd data here, parse it and return it
    if(connection.status() == obd.OBDStatus.NOT_CONNECTED):
        print('No Obd Connection')
        speed = random.randint(10, 140) # kph
        rpm = random.randint(1000, 3500) # rmp
        coolant_temp = random.randint(80, 110) # C
        throttle = random.randint(0, 100) # %
        run_time = int(time.time() - start_time) # time since program start
        fuel = random.randint(0, 100)# %
        oil_temp = random.randint(80, 110) # C
        fuel = random.randint(10, 90) # %
    else:
        speed = obd.commands.SPEED # kph
        rpm = obd.commands.RPM # rmp
        coolant_temp = obd.commands.COOLANT_TEMP # C
        throttle = obd.commands.THROTTLE_POS # %
        run_time = obd.commands.RUN_TIME # Sec
        fuel = obd.commands.FUEL_LEVEL# %
        oil_temp = obd.commands.OIL_TEMP # C
    return {
            "speed": speed,
            "rpm": rpm,
            "coolant_temp": coolant_temp,
            "throttle": throttle,
            "run_time": run_time,
            "fuel": fuel,
            "oil_temp": oil_temp
            }