library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
	generic (
		LARG_REGS: integer := 16
		LARG_SEL_OP: integer := 2
	);
	port (
		entr_a, entr_b: in unsigned(LARG_REGS-1 downto 0);
		sel_op: in unsigned(LARG_SEL_OP-1 downto 0);
		saida: out unsigned(LARG_REGS-1 downto 0);
		entr_iguais, a_maior_b, a_menor_b: out std_logic;
	);
end entity;

architecture arq_ula of ula is
signal resul_mul: unsigned(LARG_REGS*2 - 1 downto 0);
begin
	resul_mul <= entr_a * entr_b when sel_op="10" else (others=>'0');
	saida <=	entr_a + entr_b when sel_op="00" else
				entr_a - entr_b when sel_op="01" else
				resul_mul(15 downto 0) when sel_op="10" else
				
end architecture;