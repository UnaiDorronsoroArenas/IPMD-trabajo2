# Script para el lanzamiento de ambos clusters: HDFS (parte 1) y KUDU (parte 2)
rm -rf namenode
rm -rf datanode1
rm -rf datanode2
# Definir variable de entorno requerida por el cluster KUDU
IP=$(ifconfig | grep "inet " | grep -Fv 127.0.0.1 |  awk '{print $2}' | tail -1)
#Lanzar cluster
KUDU_QUICKSTART_IP=$IP docker compose up -d