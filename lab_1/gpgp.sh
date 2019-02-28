#!/bin/bash
#Authors: Group 1A, Jose Angel Morena, Aleix Iglesias i Joan Jara
#Date: 06/02/2019
#Description: 


usage()
{

	echo "Que fa el script?Aquest script, llegeix d'un fitxer on se troben diferents paths absoluts, agafa path per path i mostra els seus permisos al mateix temps que els escriu en un fitxer 'permissions.txt'."
	echo "Quines opcions admet?No admet cap opció."
	echo "Quins parametres hem de posar?Hem de passar un fitxer per parametre, no admet més parametres."
	echo "Es pot executar per qualsevol usuari"

}

wrong_option(){

	echo "Nomes s'admet l'opcio 'h'... no cap altra" 
}


while getopts "h" o; do
	case "${o}" in
		h)
			usage
			exit 0
			;;
		*)
			wrong_option
			exit 1
			;;
	esac
done


shift $((OPTIND-1))


if [[ $# -eq 0 || -z "$1" ]]; then
	echo "No has posat argument (path al fitxer)"
 	exit 2
fi       

if [[ -e "$1" && -f "$1" ]]; then
	IFS=$'\n'
	for fitxer in $(cat "$1");do
		if [ -e $fitxer ]; then
			stat -c "%U %G %a %n" $fitxer | tee -a ./permissions.txt
		else
			echo "Error Fitxer $fitxer no existeix o es tracta de un directori" >&2
		fi
	done
	unset IFS
else 
	echo "Error Fitxer "$1" no existeix o es tracta de un directori" >&2

fi

exit 0
