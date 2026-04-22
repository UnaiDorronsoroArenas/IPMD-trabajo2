-- Limpieza por si acaso
DROP TABLE IF EXISTS flights;
DROP TABLE IF EXISTS kudu_flights;
DROP TABLE IF EXISTS perday;
DROP TABLE IF EXISTS perdayparquet;
DROP TABLE IF EXISTS perdaycsv;

-- Creación de vista sobre el fichero Flights.parquet de HDFS
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
LOCATION 'hdfs://namenode:9000/user/impala/flights';

-- Esquema
DESCRIBE flights;

-- Consulta: número de vuelos por día
SELECT fl_date, count(fl_date) as f_count
FROM flights
GROUP BY fl_date
ORDER BY fl_date ASC
LIMIT 10;

-- Crear tabla almacenada en KUDU
CREATE TABLE kudu_flights (
  ID INT,
  FL_DATE DATE,
  DEP_DELAY INT,
  ARR_DELAY INT,
  AIR_TIME INT,
  DISTANCE INT,
  DEP_TIME DOUBLE,
  ARR_TIME DOUBLE,

  PRIMARY KEY (ID)
)
PARTITION BY HASH (ID) PARTITIONS 8
STORED AS KUDU;

-- Insertamos los datos almacenados en la tabla de HDFS
INSERT INTO kudu_flights
SELECT
  CAST(ROW_NUMBER() OVER (ORDER BY TRUE) as INT) AS ID,
  FL_DATE,
  DEP_DELAY,
  ARR_DELAY,
  AIR_TIME,
  DISTANCE,
  DEP_TIME,
  ARR_TIME
FROM flights;

-- Comprobar los vuelos por día
SELECT fl_date, count(fl_date) as f_count
FROM kudu_flights
GROUP BY fl_date
ORDER BY fl_date ASC
LIMIT 10;

-- Creación de tabla "perday"
CREATE TABLE perday
PRIMARY KEY (fl_date)
PARTITION BY HASH(fl_date) PARTITIONS 8
STORED AS KUDU
AS
  SELECT
    fl_date,
    COUNT(fl_date) AS f_count
  FROM FLIGHTS
  GROUP BY fl_date;

-- Guardar la tabla "perday" en HDFS con formato parquet
CREATE TABLE perdayparquet
STORED AS PARQUET
LOCATION 'hdfs://namenode:9000/user/impala/perday_parquet'
AS
  SELECT
    fl_date,
    COUNT(fl_date) AS f_count
  FROM FLIGHTS
  GROUP BY fl_date;

CREATE TABLE perdaycsv
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'hdfs://namenode:9000/user/impala/perday_csv'
AS
  SELECT
    fl_date,
    COUNT(fl_date) AS f_count
  FROM FLIGHTS
  GROUP BY fl_date;