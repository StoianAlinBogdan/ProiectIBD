#!/bin/bash

# Creare backup la baza de date
sudo docker exec -i MYSQL mysqldump -u root -p123 IBD --skip-comments > BACKUPIBD.sql
