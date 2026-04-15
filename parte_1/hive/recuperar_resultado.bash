#!/bin/bash

docker exec -it --user root hive4 hdfs dfs -get /user/hive/perday/000000_0 /workspace/
echo "Mostrando las 10 ultimas lineas de perday guardado como archivo:"
docker exec -it --user root hive4 tail /workspace/000000_0