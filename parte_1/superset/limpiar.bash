#!/bin/bash

# EJECUTAR CON SUDO
if [ "$(id -u)" -ne 0 ]; then
    echo "Ejecutar con SUDO"
    exit 1
fi

docker compose -f superset/docker-compose-image-tag.yml down -v
sudo rm -rf superset
