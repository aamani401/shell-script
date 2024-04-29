#!/bin/bash

USERID=$(id -u)
DATETIME=$(date +%F-%H-%M-%S)
FILENAME=$( echo $0 | cut -d '.' -f1 )
LOGFILENAME=/tmp/$FILENAME-$DATETIME.LOG

echo "$DATETIME"
echo "$FILENAME"
echo "$LOGFILENAME"
dnf install mysql-server -y &>>$LOGFILENAME
echo "$? output"
