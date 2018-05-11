#!/bin/bash

cd build

ghdl -a ../src/ula.vhd
ghdl -e ula

ghdl -a ../src/reg16bit.vhd
ghdl -e reg16bit

ghdl -a ../src/banco_reg.vhd
ghdl -e banco_reg

ghdl -a ../src/ula_com_banco_reg.vhd
ghdl -e ula_com_banco_reg

