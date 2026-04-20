-- Limpieza por si acaso
DROP TABLE IF EXISTS flights;
DROP TABLE IF EXISTS hive_flights;
DROP TABLE IF EXISTS perday;

-- 1)
-- El fichero Flights.parquet debe estar dentro de /user/hive en HDFS (hive.bash lo hace)
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
LOCATION 'hdfs://namenode:9000/user/hive/flights';

-- 2)
CREATE TABLE hive_flights (
  FL_DATE DATE,
  DEP_DELAY INT,
  ARR_DELAY INT,
  AIR_TIME INT,
  DISTANCE INT,
  DEP_TIME DOUBLE,
  ARR_TIME DOUBLE
)
STORED AS PARQUET
LOCATION 'hdfs://namenode:9000/user/hive/hive_flights';

-- Usamos el de HDFS para flights, para este usamos el local y asi no tocamos el otro
LOAD DATA LOCAL INPATH '/workspace/Flights.parquet' INTO TABLE hive_flights;
-- LOCAL para que no borre el archivo original


-- 3)
-- Consultas simples para comprobar que ambas tablas devuelven los mismos resultados
SELECT COUNT(*) AS total_flights FROM flights;
SELECT COUNT(*) AS total_flights FROM hive_flights;

SELECT AVG(DEP_DELAY) AS avg_dep_delay, AVG(ARR_DELAY) AS avg_arr_delay FROM flights;
SELECT AVG(DEP_DELAY) AS avg_dep_delay, AVG(ARR_DELAY) AS avg_arr_delay FROM hive_flights;

-- Todos los resultados son los mismos

-- Tabla perday en formato texto CSV con un resumen por día
CREATE TABLE perday
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'hdfs://namenode:9000/user/hive/perday'
AS
SELECT
  FL_DATE,
  COUNT(FL_DATE) AS f_count
FROM flights
GROUP BY FL_DATE;

-- El resultado de esto se puede ver con el script recuperar_resultado.bash