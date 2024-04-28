#!/bin/bash
USERID=$(id -u)
DATETIME=$(date +%F-%H-%M-%S)
FILENAME=$( echo $0 | cut -d '.' -f1 )
LOGFILENAME=/tmp/$FILENAME-$DATETIME.LOG
R=\e[31m
G=\e[32m
Y=\e[33m
N=\e[0m

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
    echo "You are a $G superuser $N"
fi

dnf install mysql -y &>>$LOGFILENAME
VALIDATE $? "Installing mysql"

dnf install git -y &>>$LOGFILENAME
VALIDATE $? "Installing git"

