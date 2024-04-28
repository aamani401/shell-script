#!/bin/bash

USERID=$(id -u)

if [$USERID -ne 0]
then 
    echo "run script with super user access"
else 
    echo "You are a superuser"
fi