#!/bin/bash

cd build

ghdl -a ../src/ula.vhd
ghdl -e ula

ghdl -a ../src/reg16bit.vhd
ghdl -e reg16bit

ghdl -a ../src/reg14bit.vhd
ghdl -e reg14bit

ghdl -a ../src/banco_reg.vhd
ghdl -e banco_reg

ghdl -a ../src/rom.vhd
ghdl -e rom

ghdl -a ../src/pc.vhd
ghdl -e pc

ghdl -a ../src/ff_t.vhd
ghdl -e ff_t

ghdl -a ../src/uc.vhd
ghdl -e uc

ghdl -a ../src/calc.vhd
ghdl -e calc
