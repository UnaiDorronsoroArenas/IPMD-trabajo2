#!/bin/bash

# -----------------------------------------
# HDFS NameNode Initialization Script
# -----------------------------------------
# This script initializes and starts the HDFS NameNode service.
# It checks if the NameNode has already been formatted; if not,
# it formats the NameNode before starting it.

# ----------------------------------------
# Este script ha sido modificado para crear la carpeta user y darle permisos de manera automatica
# -----------------------------------------

# Exit immediately if a command exits with a non-zero status
set -e

# Define the NameNode data directory
NAMENODE_DIR="/opt/hadoop/data/nameNode"

# Check if the NameNode has already been formatted
if [ ! -d "\$NAMENODE_DIR/current" ]; then
    hdfs namenode -format -force -nonInteractive
fi

# Arrancar el namenode en segundo plano para que no bloquee el script
hdfs namenode &
NAMENODE_PID=$!

# esperamos a que el namenode se haya inicializado para ejecutar los comandos sobre hdfs
until nc -z localhost 9870; do
    sleep 1
done

# Crear la carpeta /user y darle permisos
hdfs dfs -mkdir /user
hdfs dfs -chmod 777 /user
# Podemos ver el resultado con hdfs dfs -getfacl /user desde namenode

# Dejar el namenode corriendo
wait $NAMENODE_PID
