# JMX exporter
wget https://github.com/prometheus/jmx_exporter/releases/download/1.5.0/jmx_prometheus_javaagent-1.5.0.jar
mkdir -p monitorizacion/jmx/
mv jmx_prometheus_javaagent-1.5.0.jar ./monitorizacion/jmx

# Kudu prometheus exporter
wget https://github.com/leeeizhang/Prometheus-Kudu-Exporter/releases/download/v0.2.0/prometheus-kudu-exporter-binary-0.2.0.tar.gz
tar -zxvf prometheus-kudu-exporter-binary-0.2.0.tar.gz
mkdir -p monitorizacion/kudu-exporter monitorizacion/kudu-exporter/conf
mv prometheus-kudu-exporter/lib/*.jar monitorizacion/kudu-exporter
rm -rf prometheus-kudu-exporter prometheus-kudu-exporter-binary-0.2.0.tar.gz