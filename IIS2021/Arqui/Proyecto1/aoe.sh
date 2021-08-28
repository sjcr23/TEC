#!/bin/bash

# Verifico la cantidad de Argumentos (debe ser solo 1)
if [ $# -eq 1 ]
then
	# Ensambla y especifica la salida del archivo
	nasm -f elf $1.asm; ld -m elf_i386 -s -o $1 $1.o

	# Verifico si el return de lo anterior fue 0. (De ser el caso, es xq la ejecución tuco éxito)
	if [ $? -eq 0 ]
	then
		./$1
	else
		echo ""
		echo "Error02: al Compilar y Enlazar">&2
		echo ""
	fi

else
	echo ""
	echo "Error01: Se debe indicar solo 1 parámetro."
	echo "Intenta utilizando el comando: ./CEE.sh [nombre_del_archivo]"
	echo "ADVERTENCIA: Debe existir el archivo '[nombre_del_archivo].asm' en el fichero"
	echo ""
fi
