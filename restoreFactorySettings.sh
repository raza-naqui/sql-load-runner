#!/bin/bash
rm ./sql/*.*

logsDirectory=./logs
if [ "$(ls -A $logsDirectory)" ]; then
    rm ./logs/*.*
fi

crontabBackup=crontab.backup
if [ -f "$crontabBackup" ]; then
    crontab crontab.backup
fi

rm myCron