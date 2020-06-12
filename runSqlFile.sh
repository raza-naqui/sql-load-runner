#!/bin/bash
if [ "$#" -ne 4 ]; then
    echo "Incorrect Syntax!"
    echo "Please pass the required parameters DB_CONFIG_PROPERTIES_FILE, SQL_FILE, LOG_FILE, CUST_NUM"
    exit
fi

dbConfigFile=$1
sqlFile=$2
logFile=$3
custName=$4

if [ -f "$dbConfigFile" ]
then
  while IFS='=' read -r key value
  do
    key=$(echo $key | tr '.' '_')
    eval ${key}=\${value}
  done < "$dbConfigFile"

  #Connect SQL Plus here
  DB_CONNECTION_URL=${DB_USER}/${DB_PASSWORD}@${DB_HOST}/${DB_SERVICE_NAME}
  sqlplus -S $DB_CONNECTION_URL @${sqlFile} $custName > ${logFile}
  
else
  echo "The DB Config Properties File [$dbConfigFile] not found."
fi