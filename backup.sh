#!/bin/bash

# Creare backup la baza de date
sudo docker exec -it MYSQL mysqldump -uroot -p123 IBD > BACKUPIBD.sql
