#!/bin/bash

person1=$1 #nospace between = and value
person2=$2
#referring variables
echo "$person1:Hi $person2" # "$" is considered it as variable
echo "$person2: Hi $person1 how are you:"
echo "$person1 : Am good $person2 how is work"
echo "$person2 : not bad $person1 I am planning to learn devops"