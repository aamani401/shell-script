#!/bin/bash


Movies=("RRR" "Bahaubali" "Adithya369") # '()' there stands for arrays in shell

echo ${Movies[0]}
echo ${Movies[1]}
echo ${Movies[@]} # @ stands for all
echo ${Movies[5]} #gives empty output