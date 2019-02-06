#!/bin/bash
#Authors: Group 1A, Jose Angel Morena, Aleix Iglesias i Joan Jara
#Date: 06/02/2019
#Description: 

if [[ -e "$1" && -f "$1" ]]; then
	for fitxer in $(cat "$1");do
		if [[ -e $fitxer && -f $fitxer ]]; then
			stat -c "%U %G %a %n" $fitxer | tee -a ./permissions.txt
		else
			echo "Error Fitxer $fitxer no existeix o es tracta de un directori" >&2
		fi
	done
else 
	echo "Error Fitxer "$1" no existeix o es tracta de un directori" >&2

fi

