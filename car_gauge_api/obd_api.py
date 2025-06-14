from fastapi import FastAPI
import time
import obd
import random

app = FastAPI()
connection = obd.OBD()
#connection = obd.Async() # Code for async connection if needed
start_time = time.time()

# ---- ASYNC UPDATE CODE ----- #
# Initializing all the varaibles to zero
# speed = 0
# rpm = 0
# coolant_temp = 0 
# throttle = 0 
# run_time = 0 
# fuel = 0
# oil_temp = 0

# This code will constantly check the obd data in the background and when queried 
# will return the most recent value instead of waiting for a response
# connection.watch(obd.commands.SPEED)
# connection.watch(obd.commands.RPM)
# connection.watch(obd.commands.COOLANT_TEMP)
# connection.watch(obd.commands.THROTTLE_POS)
# connection.watch(obd.commands.RUN_TIME)
# connection.watch(obd.commands.FUEL_LEVEL)
# connection.watch(obd.commands.OIL_TEMP)
# connection.start()

@app.get("/") # http://127.0.0.1:8000/
def read_root():
    return getObdData()

def getObdData():
    global connection 
    # Check for a connection before trying to pull data
    if(connection.status() == obd.OBDStatus.NOT_CONNECTED):
        connection = obd.OBD() # Attempt a reconnection
        speed = random.randint(10, 140) # kph
        rpm = random.randint(1000, 3500) # rmp
        coolant_temp = random.randint(80, 110) # C
        throttle = random.randint(0, 100) # %
        run_time = int(time.time() - start_time) # time since program start
        fuel = random.randint(0, 100)# %
        oil_temp = random.randint(80, 110) # C
    # Read obd data here, parse it and return it
    else:
        speed = connection.query(obd.commands.SPEED).value # kph
        rpm = connection.query(obd.commands.RPM).value # rmp
        coolant_temp = connection.query(obd.commands.COOLANT_TEMP).value # C
        throttle = connection.query(obd.commands.THROTTLE_POS).value # %
        run_time = connection.query(obd.commands.RUN_TIME).value # Sec
        fuel = connection.query(obd.commands.FUEL_LEVEL).value # %
        oil_temp = connection.query(obd.commands.OIL_TEMP).value # C
    return {
            "speed": speed,
            "rpm": rpm,
            "coolant_temp": coolant_temp,
            "throttle": throttle,
            "run_time": run_time,
            "fuel": fuel,
            "oil_temp": oil_temp
            }