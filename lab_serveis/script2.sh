#!/bin/bash

last_backup=$(ls -t /back | head -1)	#last backupfile

tar -xvzf  "/back/$last_backup/"*".tgz"	#x:extract;v:verbose;z:gnuzip;f:for file

while read owner group permissions file; do
	if grep -q $group /etc/group ; then	#option -q does not write any output
		echo "group, " $group ", exists"
		if  grep  -q  $owner /etc/passwd  ; then
			echo "owner, " $owner ", exists"
		else 
			echo "owner, " $owner ",  does not exist"
		fi

		if ! [ -e "$file" ] ; then
			echo "file, "$file "does not exists"
			u=$(stat -c %U $file 2> /dev/null)
			g=$(stat -c %G $file 2> /dev/null)
			p=$(stat -c %U $file 2> /dev/null)
			#if [[ "$u" = "$owner" && "$g" = "$group" && "$p" = "$permissions" ]] ; then #si pertany a un altre o permisos son diferents
			echo "PERMISOS BE"
			f=${file##*/} #split and get last
			mv "$f" "$file" 2> /dev/null

			#fi
		else
			echo "file, " $file " does not exist"
		fi
	else
		echo "no existeix grup, " $group
	fi

done < "permissions.txt"
