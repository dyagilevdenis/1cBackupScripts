#!/bin/bash

cd /home/temp/ftp/files
count=`ls *.zip | wc -l`
if [ $count != 0 ]
then
   folder=$(date +"%d-%m-%Y %H:%M:%S")
   mkdir "/media/denis/backup/$folder"   
   find . -name '*.zip' -exec mv '{}' "/media/denis/backup/$folder" \;
else
   echo No
fi
