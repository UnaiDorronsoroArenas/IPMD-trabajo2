#!/bin/bash

docker exec -it --user root hive4 hdfs dfs -fs hdfs://namenode:9000 -get /user/hive/perday/000000_0 /workspace/
echo "Mostrando las 10 ultimas lineas de perday guardado como archivo:"
docker exec -it --user root hive4 tail /workspace/000000_0