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
			echo "Unknown option $key"
			exit
		;;
	esac
done

cd build

ghdl -a ../src/ula.vhd
ghdl -e ula

ghdl -a ../src/reg16bit.vhd
ghdl -e reg16bit

ghdl -a ../src/reg14bit.vhd
ghdl -e reg14bit

ghdl -a ../src/monoestavel.vhd
ghdl -e monoestavel

ghdl -a ../src/banco_reg.vhd
ghdl -e banco_reg

ghdl -a ../src/rom.vhd
ghdl -e rom

ghdl -a ../src/pc.vhd
ghdl -e pc

ghdl -a ../src/ff_t.vhd
ghdl -e ff_t

ghdl -a ../src/ram.vhd
ghdl -e ram

ghdl -a ../src/uc.vhd
ghdl -e uc

ghdl -a ../src/processador.vhd
ghdl -e processador

if [[-n $OUTPUT]]
then
	if[[-z $STOPTIME]]
	then
		STOPTIME="1000ns"
	fi
	ghdl -a ../testes/processador_teste.vhd
	ghdl -e processador_teste
	ghdl -r processador_teste --wave=$OUTPUT --stop-time=$STOPTIME
fi