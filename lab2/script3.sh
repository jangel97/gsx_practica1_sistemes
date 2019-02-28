#!/bin/bash
#Autors: Grup 1A; Jose Angel Morena, Joan Jara, Aleix Iglesias
#Descripcio: Script que mira les procesos que ...
#$1: user

#FALTA -h I CONTROLAR EL ROOT

IFS=$'\n'
#comm="lastcomm --user $1"
#comm = ps -o pid,stime,cmd -u $1

for op in $(lastcomm --strict-match --user $1 | grep DX); do
	
	var=echo $op | awk '{print $NF}' | awk 'BEGIN {FS=":";} {print $1}'
	echo $var	#printa las horas de los proceses 
	
	#start= "echo '$op' | awk '{print $NF}'"
	#echo $(start)
	#start=$op |  awk 'NF{ print $NF }'
done


#lastcomm --strict-match --user milax | awk '{print $2}'

