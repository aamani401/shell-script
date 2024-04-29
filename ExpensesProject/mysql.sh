#!/bin/bash

USERID=$(id -u)
DATETIME=$(date +%F-%H-%M-%S)
FILENAME=$( echo $0 | cut -d '.' -f1 )
LOGFILENAME=/tmp/$FILENAME-$DATETIME.LOG
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$2 is $R failure $N"
    else
        echo -e "$2 is $G success $N"

    fi
}
if [ $USERID -ne 0 ]
then 
    echo "run script with super user access"
    exit 1
else 
    echo -e "You are a $G superuser $N"
fi

dnf install mysql-server -y &>>$LOGFILENAME
VALIDATE $? "Installing mysql"

systemctl enable mysqld &>>$LOGFILENAME
VALIDATE $? "Enable mysql"

systemctl start mysqld &>>$LOGFILENAME
VALIDATE $? "start mysqld"

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILENAME
VALIDATE $? "set root pass"