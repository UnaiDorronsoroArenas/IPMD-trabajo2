#!/bin/bash

# -----------------------------------------
# HDFS DataNode Initialization Script
# -----------------------------------------
# This script initializes and starts the HDFS DataNode service.
# It ensures that the DataNode's data directory is clean,
# has the correct permissions, and is ready for use.

# Exit immediately if a command exits with a non-zero status
set -e

# Define the DataNode data directory
DATANODE_DIR="/opt/hadoop/data/dataNode"

# Check if the DataNode directory exists
if [ -d "\$DATANODE_DIR" ]; then
    rm -rf "\$DATANODE_DIR"/*
else
    mkdir -p "\$DATANODE_DIR"
fi

# Set correct ownership and permissions
chown -R hadoop:hadoop "\$DATANODE_DIR"
chmod 755 "\$DATANODE_DIR"

# Start the DataNode service
hdfs datanode

# Make the script executable
chmod +x init-datanode.sh
