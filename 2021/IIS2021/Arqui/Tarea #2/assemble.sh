#!/bin/bash

# Verifico la cantidad de Argumentos (debe ser solo 1)
if [ $# -eq 1 ]
then
	# Convierto a código objeto, enlazo y especifico la salida del archivo.
	nasm -F dwarf -f elf64 $1.asm && ld $1.o -o $1 && ./$1

else
	echo ""
	echo "Error01: Se debe indicar solo 1 parámetro."
	echo "Intenta utilizando el comando: ./assemble.sh [nombre_del_archivo]"
	echo "ADVERTENCIA: Debe existir el archivo '[nombre_del_archivo].asm' en el fichero"
	echo ""
fi
