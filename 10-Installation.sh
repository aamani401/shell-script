#!/bin/bash

USERID=$(id -u)
echo "$USERID"
if [ $USERID -ne 0 ]
then 
    echo "run script with super user access"
    exit 1
else 
    echo "You are a superuser"
fi

dnf install mysql -y
if [ $? -ne 0]
then
    echo "installation of mysql is not success"
    exit 1
fi

echo "is script proceeding?"