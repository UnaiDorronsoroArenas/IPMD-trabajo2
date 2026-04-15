#!/bin/bash
# Cargar Flights.parquet en tablas de Hive

docker exec --user root hive4 hadoop fs -mkdir -p /user
docker exec --user root hive4 hadoop fs -chmod 777 /user
docker exec --user root hive4 hadoop fs -mkdir -p /user/hive
docker exec --user root hive4 hadoop fs -mkdir -p /user/hive/tables
docker exec --user root hive4 hdfs dfs -put /workspace/Flights.parquet /user/hive/Flights.parquet
docker exec -it hive4 beeline -u 'jdbc:hive2://localhost:10000/'
