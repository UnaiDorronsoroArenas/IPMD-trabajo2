import pyarrow.parquet as pq
import numpy as np
import pandas as pd

data = pq.read_table('../Flights.parquet')
print(data)

# Hemos dejado la salida en output.txt
# Analisis:
"""
Contiene 7 columnas:
- FL_DATE: date32[day]
    Contiene el dia de salida del vuelo
- DEP_DELAY: int16
    Contiene el retraso que con el que ha salido el vuelo (o negativo si ha salido antes de tiempo)
    Entendemos que en minutos
- ARR_DELAY: int16
    Lo mismo que el anterior pero para la llegada
- AIR_TIME: int16
    El tiempo (entendemos que en minutos) que ha pasado el avion en el aire
- DISTANCE: int16
    La distancia (entendemos que en KM) que ha recorrido el vuelo
- DEP_TIME: float
    La hora del dia (0 - 23) a la que ha despegado el avion. Está convertida a decimal
    Ex: 19:30 -> 19.5
- ARR_TIME: float
    Lo mismo que el anterior pero para la llegada
"""