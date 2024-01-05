#!/bin/bash

# Setup pyspark environment
sudo chmod 777 ./notebooks # This is needed for the mount to work -> different gid in the container
sudo docker run --group-add=100 -p 8888:8888 -v $(pwd)/notebooks/:/home/jovyan/notebooks/ -d jupyter/pyspark-notebook

# Download the dataset if it isn't already downloaded - do not commit it, its huge!
cd ./notebooks
if ! [ -f ./dataset.csv ]; then
	curl "https://data.cityofnewyork.us/api/views/8h9b-rp9u/rows.csv?date=20240105&accessType=DOWNLOAD" -o dataset.csv
fi

