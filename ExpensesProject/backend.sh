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

dnf module disable nodejs -y &>>$LOGFILENAME
VALIDATE $? "Disable nodejs"

dnf module enable nodejs:20 -y &>>$LOGFILENAME
VALIDATE $? "enable nodejs 20 Version"

dnf install nodejs -y &>>$LOGFILENAME
VALIDATE $? "installing nodejs"

id expense &>>$LOGFILE
if [ $? -ne 0 ]
then
    useradd expense &>>$LOGFILE
    VALIDATE $? "Creating expense user"
else
    echo "Expense user already created...SKIPPING "
fi

mkdir -p /app &>>$LOGFILENAME
VALIDATE $? "MKDIR app"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOGFILENAME
VALIDATE $? "Download backend"


cd /app 
unzip /tmp/backend.zip &>>$LOGFILENAME
VALIDATE $? "extract backend"
npm install &>>$LOGFILENAME
VALIDATE $? "Install nodejs dependencies"

cp /home/ec2-user/shell-script/ExpensesProject/backend.service /etc/systemd/system/backend.service
VALIDATE $? "Copying backend.service file"

systemctl daemon-reload &>>$LOGFILENAME
VALIDATE $? "daemon-reload"

systemctl start backend &>>$LOGFILENAME
VALIDATE $? "start backend"

systemctl systemctl enable backend &>>$LOGFILENAME
VALIDATE $? "enable backend"

dnf install mysql -y &>>$LOGFILENAME
VALIDATE $? "install mysql"

mysql -h 34.201.111.22 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$LOGFILENAME
VALIDATE $? "Load schema"

systemctl restart backend &>>$LOGFILENAME
VALIDATE $? "restart backend"