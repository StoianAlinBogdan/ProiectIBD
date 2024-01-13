#!/bin/bash

# Replicate the database backup on another instance

# Build another MySQL instance
sudo docker run -d --name MYSQL_REPLICA -e MYSQL_ROOT_PASSWORD=123 -p 3307:3306 mysql

# Create a database replica
sudo docker exec -it MYSQL_REPLICA mysql -u root -p123 -e "CREATE DATABASE IF NOT EXISTS IBDREPLICA"

# Import the backup
sudo docker exec -i MYSQL_REPLICA mysql -u root -p123 IBDREPLICA < BACKUPIBD.sql
