# Detenemos y borramos el contenedor si fue creado con anterioridad
docker stop kudu-impala
docker rm kudu-impala

# Lanzamos el contenedor
docker run -d --name kudu-impala --network="practica2_network" \
  -e JAVA_HOME="/usr" \
  -v ../../Flights.parquet:/workspace/Flights.parquet \
  -v $(pwd):/workspace \
  -p 21000:21000 -p 21050:21050 -p 25000:25000 -p 25010:25010 -p 25020:25020 \
  --memory=4096m apache/kudu:impala-latest impala

# Esperamos a que el contenedor arranque
sleep 15

# Creamos el directorio /user/impala/flights y copiamos ahí el archivo de vuelo .parquet del workspace
docker exec kudu-impala /bin/bash -c "hadoop fs -fs hdfs://namenode:9000 -mkdir -p /user/impala/flights"
docker exec kudu-impala /bin/bash -c "hadoop fs -fs hdfs://namenode:9000 -put /workspace/Flights.parquet /user/impala/flights/"
# Comprobamos que el fichero ha sido copiado correctamente
docker exec kudu-impala /bin/bash -c "hadoop fs -fs hdfs://namenode:9000 -ls /user/impala/flights"

# Realización de los ejercicios
docker exec kudu-impala /bin/bash -c "impala-shell -f /workspace/ejercicios.sql"

# Copiar los ficheros parquet y CSV generados en /workspace
docker exec kudu-impala hadoop fs -fs hdfs://namenode:9000 -get /user/impala/perday_parquet /workspace
docker exec kudu-impala hadoop fs -fs hdfs://namenode:9000 -get /user/impala/perday_csv /workspace