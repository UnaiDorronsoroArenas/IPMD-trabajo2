#!/bin/bash

# Despues de hacer docker compose down hay que ejecutar esto para limpiar las carpetas residuales que han quedado
# Si se intenta hacer docker compose up de nuevo sin limpiar, el cluster puede no funcionar
# Para evitar este lio, podemos usar este sencillo script para reiniciar

# EJECUTAR CON SUDO
if [ "$(id -u)" -ne 0 ]; then
    echo "Ejecutar con SUDO"
    exit 1
fi

docker compose down


rm -rf namenode
rm -rf datanode1
rm -rf datanode2

docker compose up