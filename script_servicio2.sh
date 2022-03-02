#!/bin/bash


while [ 0 -eq 0 ];
do
	echo "========================================"
	echo "Instalacion del servicio de impresion"
	echo "========================================"
	echo "1. Instalar servicio"
	echo "2. Comprobar el estado del servicio"
	echo "3. Pasos para continuar con la instalacion"
	echo "4. Salir"
	read -p "¿Cual opcion vas a elegir 1, 2, 3 o 4? " respuesta
	if [ $respuesta == "1" ]; then
		echo "======================================="
		echo "Se va a empezar a actualizar el sistema"
		echo "======================================="
		sudo apt update -y
		sudo apt upgrade -y
		sleep 2
		echo ""
		echo "====================================="
		echo "Se instalara el servicio de impresion"
		echo "====================================="
		sudo apt install cups
		echo "====================================="
		echo ""
		read -p "Dime tu nombre de usuario: " usuario

		if [ $usuario ]; then
			comp_usu=`getent passwd | cut -d: -f1 | grep -E "\b$usuario\b"`
			if [ ! -e $comp_usu ]; then
				echo "Tu usuario $usuario existe"
				echo "Vamos a asignar el usuario $usuario al grupo lpadmin"
				echo ""
				sudo usermod -a -G lpadmin $usuario
				sudo cupsctl --remote-any
				echo ""
				echo "================================"
				echo "Se esta reiniciando el servicio"
				echo "================================"
				echo ""
				sudo /etc/init.d/cups restart
				echo ""
				echo "================================"
				echo "Instalamos la impresora PDF."
				echo "================================"
				echo ""
				sudo apt install cups-pdf
				ip=`hostname -I | cut -d" " -f1`
				echo ""
				echo "========================================="
				echo "Tienes que escribir esta ruta en tu firefox: "
				echo ""
				echo "$ip:631"
				echo "========================================"
				echo ""
				echo "En la opcion 3 del menu te damos los pasos para continuar con la configuracion"
				sleep 2
				echo ""
				#echo "Se va a abrir FireFox"
				#firefox

			else
				echo "El usuario $usuario no existe"
			fi
		else
			echo "No has introduciro el nombre de usuario"
		fi
	fi

	if [ $respuesta == "2" ]; then
		echo ""
		echo "======================================================"
		echo "Pulsa la letra q para salir despues de la comprobacion"
		echo "======================================================"
		echo ""
		sleep 2
		systemctl status cups
		echo ""
	fi
	if [ $respuesta == "3" ]; then
		echo "Estos son los pasos para la configuracion de la impresora."
		echo "======================================================="
		echo ""
		echo "1. Para añadir la impresora le das clic en la opcion 'Añadir impresoras y clases.'"
		echo ""
		echo "2. Luego le das clic en 'Añadir impresora.'"
		echo ""
		echo "3. Despues seleccionas la impresora 'CUPS-PDF (Virtual PD Printer)'."
		echo ""
		echo "4. Luego de las a siguiente en las dos opciones pero antes le das a compartir esta impresora"
		echo ""
		echo "5. En el siguiente apartado elegimos 'Generic' y le damos a siguiente."
		echo ""
		echo "6. En el siguiente apartado elegimos 'Generic PDF Printer (en)' luego a 'Añadir impresora'."
		echo ""
		echo "7. Y en la siguiente ventana dejamos todo por defecto."
		echo ""
		echo "8. Y ya estaria funcionando tu impresora."
		echo ""
		echo "===================================================================="
		echo "Se va a abrir FireFox"
		echo ""
		firefox
	fi

	if [ $respuesta == "4" ]; then
		echo ""
		echo "Adios"
		break
	fi

done
