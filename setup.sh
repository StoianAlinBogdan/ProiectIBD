#!/bin/bash

# Setup pyspark environment
sudo chmod 777 ./notebooks # This is needed for the mount to work -> different gid in the container
sudo docker run --group-add=100 -p 8888:8888 -v $(pwd)/notebooks/:/home/jovyan/notebooks/ --net host -d jupyter/pyspark-notebook

# Download the dataset if it isn't already downloaded - do not commit it, its huge!
cd ./notebooks
if ! [ -f ./dataset.csv ]; then
	curl "https://data.cityofnewyork.us/api/views/8h9b-rp9u/rows.csv?date=20240105&accessType=DOWNLOAD" -o dataset.csv
fi

# Build and run kafka instance
cd ../kafka
sudo docker build . -t kafka
sudo docker run -d -p 9092:9092 --net host kafka

# Build and run MYSQL instance
sudo docker pull mysql
sudo docker run --name MYSQL -e MYSQL_ROOT_PASSWORD=123 -d -p 3306:3306 --net host mysql

# Create the database
sudo docker exec -it MYSQL mysql -u root -p123 -e "CREATE DATABASE IF NOT EXISTS IBD;"

# Build another MySQL instance for replica
sudo docker run -d --name MYSQL_REPLICA -e MYSQL_ROOT_PASSWORD=123 -p 3307:3306 mysql
