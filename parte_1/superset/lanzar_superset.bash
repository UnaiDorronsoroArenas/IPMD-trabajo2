#!/bin/bash

# IMPORTANTE: Ejecutar con la terminal en la carpeta parte_1/superset

git clone https://github.com/apache/superset.git

cd superset
git checkout tags/6.0.0

echo "Advertencia! Este proceso es lento y puede tardar entre 5 y 10 minutos"

docker compose -f docker-compose-image-tag.yml up -d

CONTAINER_NAME="superset_init"

while ! docker inspect "$CONTAINER_NAME" >/dev/null 2>&1; do
  sleep 1
done

echo "Container $CONTAINER_NAME now exists."

while [ "$(docker inspect -f '{{.State.Running}}' "$CONTAINER_NAME" 2>/dev/null)" = "true" ]; do
  sleep 1
done

echo "Container $CONTAINER_NAME has stopped."

docker exec superset_app pip install thrift thrift-sasl
docker network connect practica_2_practica2_network superset_app
cd ..

echo "Superset se ha iniciado correctamente!"
echo "Para conectar con Hive: (arriba a la derecha) + -> data -> connect database -> Other"
echo "Display name: Hive"
echo "URI hive://hive:10000/default"
