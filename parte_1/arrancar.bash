#!/bin/bash
# Cargar Flights.parquet en tablas de Hive

docker exec namenode hadoop fs -mkdir -p /user
docker exec namenode hadoop fs -chmod 777 /user

docker exec --user root hive4 hadoop fs -fs hdfs://namenode:9000 -mkdir /user/hive
#docker exec --user root hive4 hadoop fs -fs hdfs://namenode:9000 -chmod 777 /user/hive

docker exec --user root hive4 hadoop fs -fs hdfs://namenode:9000 -mkdir /user/hive/flights
#docker exec --user root hive4 hadoop fs -fs hdfs://namenode:9000 -chmod 777 /user/hive/flights

docker exec --user root hive4 hdfs dfs -fs hdfs://namenode:9000 -put /workspace/Flights.parquet /user/hive/flights/Flights.parquet
#docker exec --user root hive4 hadoop fs -fs hdfs://namenode:9000 -chmod 777 /user/hive/flights/Flights.parquet

docker exec --user root hive4 hadoop fs -fs hdfs://namenode:9000 -mkdir /user/hive/perday
docker exec --user root hive4 hadoop fs -fs hdfs://namenode:9000 -chmod 777 /user/hive/perday

docker exec --user root hive4 hadoop fs -fs hdfs://namenode:9000 -mkdir /user/hive/hive_flights
docker exec --user root hive4 hadoop fs -fs hdfs://namenode:9000 -chmod 777 /user/hive/hive_flights

docker exec -it hive4 beeline -u 'jdbc:hive2://localhost:10000/'
