#!/bin/bash

cd /home/temp/ftp/files

for file in $(ls *.zip); do

   filename="${file%%.*}"
 
   if test -f "${filename}OK.txt"; then
   
      folder=$(date +"%d-%m-%Y %H:%M:%S")
      mkdir "/media/backup/$folder" 
      mv "${file}" "/media/backup/$folder" 
      rm -f "${filename}OK.txt"
      
   fi 
   
done

