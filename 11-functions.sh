#!/bin/bash
USERID=$(id -u)
DATETIME=$(date +%F-%H-%M-%S)
FILENAME=$( echo $0 | cut -d '.' -f1 )
LOGFILENAME=$($FILENAME-$DATETIME).LOG
echo "$USERID"

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo "$2 is failure"
    else
        echo "$2 is success"

    fi
}
if [ $USERID -ne 0 ]
then 
    echo "run script with super user access"
    exit 1
else 
    echo "You are a superuser"
fi

dnf install mysql -y $>>$LOGFILENAME
VALIDATE $? "Installing mysql"

dnf install git -y &>>$LOGFILENAME
VALIDATE $? "Installing git"

