#!/bin/bash

# Replicate the database backup on another instance

# Create a database replica
sudo docker exec -it MYSQL_REPLICA mysql -u root -p123 -e "CREATE DATABASE IF NOT EXISTS IBDREPLICA"

# Import the backup
sudo docker exec -i MYSQL_REPLICA mysql -u root -p123 IBDREPLICA < BACKUPIBD.sql
