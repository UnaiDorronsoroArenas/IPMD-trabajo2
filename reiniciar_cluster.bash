#!/bin/bash

# Despues de hacer docker compose down hay que ejecutar esto para limpiar las carpetas residuales que han quedado
# Si se intenta hacer docker compose up de nuevo sin limpiar, el cluster puede no funcionar
# Para evitar este lio, podemos usar este sencillo script para reiniciar

# EJECUTAR CON SUDO
if [ "$(id -u)" -ne 0 ]; then
    echo "Ejecutar con SUDO"
    exit 1
fi

IP=$(ifconfig | grep "inet " | grep -Fv 127.0.0.1 |  awk '{print $2}' | tail -1)

KUDU_QUICKSTART_IP=$IP docker compose down -v

# HDFS
rm -rf namenode
rm -rf datanode1
rm -rf datanode2

bash launch_clusters.sh