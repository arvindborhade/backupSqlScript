# backupSqlScript
Backup Mysql for daily Backup 

0 	2 	* 	* 	* 	/home/user23jk/public_html/mysql_backup_script.sh



#!/bin/bash

# Database credentials
 user="XXXXXXXX"
 password="XXXXXX"
 host="localhost"
 db_name="XXXXXXX"
# Other options
 backup_path="/home/XXX/XX"
 date=$(date +"%d-%b-%Y")
# Set default file permissions
 umask 177
 
# Dump database into SQL file
mysqldump --user=$user --password=$password --host=$host $db_name > $backup_path/$db_name-$date.sql

gzip $backup_path/$db_name-$date.sql

# Delete files older than 30 days
 find $backup_path/* -mtime +30 -exec rm {} \;
 
uuencode $backup_path/$db_name-$date.sql.gz $db_name-$date.sql.gz | mail -s "Backup Of Ucash Database $(date +"%d-%b-%Y")" email@gmail.com
