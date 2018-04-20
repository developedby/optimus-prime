library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
  port (
    entr_a, entr_b: in unsigned(15 downto 0);
    sel_op: in unsigned(2 downto 0);
    saida: out unsigned(15 downto 0);
    entr_iguais, a_maior_b: out unsigned
  );
end entity;

architecture arq_ula of ula is
signal resul_mul: unsigned(31 downto 0);
begin
  resul_mul <= entr_a * entr_b when sel_op = 2 else (others=>'0');
  saida <= entr_a + entr_b when sel_op = 0 else
           entr_a - entr_b when sel_op = 1 else
           resul_mul(15 downto 0) when sel_op = 2 else
           entr_a / entr_b when sel_op = 3 and entr_b /= (others=>'0') else
	   (others=>'0');
  entr_iguais <= '1' when entr_a = entr_b else
                 '0';
  a_maior_b <= entr_a > entr_b;
end architecture;
