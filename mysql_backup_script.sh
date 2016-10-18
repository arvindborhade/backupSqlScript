#!/bin/bash

# Database credentials
 user="XXXXXXXXXXX"
 password="XXXXXXX"
 host="localhost"
 db_name="XXXXXXXXXX"
# Other options
 backup_path="/home/XXX/XXX"
 date=$(date +"%d-%b-%Y")
# Set default file permissions
 umask 177
 
# Dump database into SQL file
mysqldump --user=$user --password=$password --host=$host $db_name > $backup_path/$db_name-$date.sql

gzip $backup_path/$db_name-$date.sql

# Delete files older than 30 days
 find $backup_path/* -mtime +30 -exec rm {} \;
 
uuencode $backup_path/$db_name-$date.sql.gz $db_name-$date.sql.gz | mail -s "Backup Of Ucash Database $(date +"%d-%b-%Y")" gmail@email.in
