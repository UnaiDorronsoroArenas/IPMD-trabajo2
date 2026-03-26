#!/bin/bash

# -----------------------------------------
# HDFS NameNode Initialization Script
# -----------------------------------------
# This script initializes and starts the HDFS NameNode service.
# It checks if the NameNode has already been formatted; if not,
# it formats the NameNode before starting it.

# Exit immediately if a command exits with a non-zero status
set -e

# Define the NameNode data directory
NAMENODE_DIR="/opt/hadoop/data/nameNode"

# Check if the NameNode has already been formatted
if [ ! -d "\$NAMENODE_DIR/current" ]; then
    hdfs namenode -format -force -nonInteractive
fi

# Start the NameNode service
hdfs namenode
# Make the script executable
chmod +x start-hdfs.sh
