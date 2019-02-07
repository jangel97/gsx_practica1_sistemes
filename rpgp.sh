#!/bin/bash
#Autors: Jose Angel Morena, Joan Jara, Aleix Iglesias

if [[ -e "$1" && -f "$1" ]]; then
	while read nom grup permisos fitxer; do
		if [ -e $fitxer ]; then
			u=$(stat -c %U $fitxer)	#possible millora amb awk (?)
			g=$(stat -c %G $fitxer)
			p=$(stat -c %a $fitxer)
			if [[ "$p" != "$permisos" || "$u" != "$nom" || "$g" != "$grup" ]]; then
				echo "Informacio al fitxer: $nom , $grup, $permisos, $fitxer"
				echo "Informacio real/actual: $u, $g, $p, $fitxer"
				read -p "Esta segur de modificar els permisos per a aquests (y/n)" yn < /dev/tty	#redireccio al terminal
				if [[ $yn == 'Y' || $yn == 'y' ]]; then
					if [ "$p" != "$permisos" ]; then
						chmod $permisos $fitxer
						echo "Els permisos del fitxer: $fitxer, han sigut modificats"
					fi
					if [ "$u" != "$nom" ]; then
						chown $nom $fitxer
						echo "El propietari del fitxer: $fitxer, ha canviat a $nom"
					fi
					if [ "$g" != "$grup" ]; then
						chgrp $grup $fitxer
						echo "El grup del fitxer: $fitxer, ha canviat a $grup"
					fi					
				
				fi
				echo
			fi
		else 
			echo "Error: El fitxer $fitxer no existeix" >&2
		fi
	done < "$1"	#que passaria si poses 3<, en lloc de < (?)

else
	echo "No existeix el fitxer o es un directori..." >&2
fi

#me encontrare la salida de varios ficheros, tipo 1er script, 
#fichero por ficher habra q ir... quieres cmabiar esto por esto?
#si hay diferencias se cambia
