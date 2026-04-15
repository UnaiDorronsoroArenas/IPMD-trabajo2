DROP TABLE IF EXISTS flights;
DROP TABLE IF EXISTS hive_flights;
DROP TABLE IF EXISTS perday;

CREATE EXTERNAL TABLE flights (
  FL_DATE DATE,
  DEP_DELAY INT,
  ARR_DELAY INT,
  AIR_TIME INT,
  DISTANCE INT,
  DEP_TIME DOUBLE,
  ARR_TIME DOUBLE
)
STORED AS PARQUET
LOCATION '/user/hive';

-- LOAD DATA INPATH '/user/hive/Flights.parquet' OVERWRITE INTO TABLE flights;
-- El fichero Flights.parquet debe estar dentro de /user/hive en HDFS

CREATE TABLE hive_flights
STORED AS PARQUET
AS SELECT * FROM flights;

-- Consultas simples para comprobar que ambas tablas devuelven los mismos resultados
SELECT COUNT(*) AS total_flights FROM flights;
SELECT COUNT(*) AS total_flights FROM hive_flights;

SELECT AVG(DEP_DELAY) AS avg_dep_delay, AVG(ARR_DELAY) AS avg_arr_delay FROM flights;
SELECT AVG(DEP_DELAY) AS avg_dep_delay, AVG(ARR_DELAY) AS avg_arr_delay FROM hive_flights;

-- Tabla perday en formato texto CSV con un resumen por día
CREATE TABLE perday (
  FL_DATE DATE,
  flights_count BIGINT,
  avg_dep_delay DOUBLE,
  avg_arr_delay DOUBLE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
AS

SELECT
  FL_DATE,
  COUNT(FL_DATE) AS f_count,
FROM flights
GROUP BY FL_DATE;
