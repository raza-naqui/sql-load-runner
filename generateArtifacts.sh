#!/bin/bash
if [ "$#" -ne 1 ]; then
    echo "Incorrect Syntax!"
    echo "Please pass CSV File: ./generateArtifacts.sh <CSVFILE>"
    exit
fi
source ./utilities.sh
inputCsvFile=$1
rowCounter=0

crontabBackup=crontab.backup
logConsole "Checking if Crontab Backup exists"
if [ ! -f "$crontabBackup" ]; then
    logConsole "$crontabBackup does not exist."
    logConsole "Taking Backup now"
    crontab -l > crontab.backup
    logConsole "Crontab backed-up to file $crontabBackup"

else
    logConsole "$crontabBackup exist."
fi

logConsole "Reading CSV to generate Crontab and SQL Files"

echo -ne "" > myCron
{
    read
    while IFS=, read -r SUBMITTIME QUERY
    do
        queryTime=`echo $SUBMITTIME | sed 's/ *$//g'`
        query=`echo $QUERY | sed 's/ *$//g'`
        rowCounter=$(( $rowCounter + 1 ))
        cronExpression=$(date -j -f '%d/%m/%Y %H:%M' "$queryTime" +'%M %H %d %m *'); 
	#The above expression won't work in some versions of Linux, in such case please use the below line
        #cronExpression=$(date +'%M %H %d %m *' -d "$queryTime");
        echo "${query}" > "./sql/query-${rowCounter}.sql"
        echo "${cronExpression} ./runSqlFile.sh ./sql/query-${rowCounter}.sql ./logs/query-${rowCounter}.log" >> myCron       
    done
} < $inputCsvFile

logConsole "Generated SQL Files in \"sql\" folder"
logConsole "Generated Cron File as \"myCron\""

#install new cron file
logConsole "Installing New Cron File"
crontab myCron
logConsole "Crontab Installed"
#rm myCron
