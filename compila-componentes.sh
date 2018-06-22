#!/bin/bash

while [[ $# -gt 0 ]]
do
	key="$1"

	case $key in
		-o|--output|-w|--wave) # output
			OUTPUT="$2"
			shift # past argument
			shift # past value
		;;
		-t|--time|--stoptime) # stop time
			STOPTIME="$2"
			shift # past argument
			shift # past value
		;;
		*)    # unknown option
			echo "'$key': opção desconhecida"
			exit
		;;
	esac
done

cd build

echo "compilando ULA..."
ghdl -a ../src/ula.vhd
ghdl -e ula

echo "compilando REG16BIT..."
ghdl -a ../src/reg16bit.vhd
ghdl -e reg16bit

echo "compilando REG14BIT..."
ghdl -a ../src/reg14bit.vhd
ghdl -e reg14bit

echo "compilando MONOESTAVEL..."
ghdl -a ../src/monoestavel.vhd
ghdl -e monoestavel

echo "compilando BANCO_REG..."
ghdl -a ../src/banco_reg.vhd
ghdl -e banco_reg

echo "compilando ROM..."
ghdl -a ../src/rom.vhd
ghdl -e rom

echo "compilando PC..."
ghdl -a ../src/pc.vhd
ghdl -e pc

echo "compilando FF_T..."
ghdl -a ../src/ff_t.vhd
ghdl -e ff_t

echo "compilando RAM..."
ghdl -a ../src/ram.vhd
ghdl -e ram

echo "compilando UC..."
ghdl -a ../src/uc.vhd
ghdl -e uc

echo "compilando PROCESSADOR..."
ghdl -a ../src/processador.vhd
ghdl -e processador

if [[ -n $OUTPUT ]]
then
	if [[ -z $STOPTIME ]]
	then
		STOPTIME="1000ns"
	fi
	echo "gerando onda..."
	ghdl -a ../testes/processador_teste.vhd
	ghdl -e processador_teste
	ghdl -r processador_teste --wave=$OUTPUT --stop-time=$STOPTIME --ieee-asserts=disable

fi
