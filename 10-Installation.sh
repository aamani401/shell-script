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

dnf install mysql -f
echo "is script proceeding?"