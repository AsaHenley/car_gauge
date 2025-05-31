from fastapi import FastAPI
import random

app = FastAPI()

@app.get("/")
def read_root():
    return getObdData()



def getObdData():
    # Read obd data here, parse it and return it
    speed = random.randint(10, 140)
    fuel = random.randint(10, 90)
    return {"speed": speed,
            "fuel": fuel}