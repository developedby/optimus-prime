library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
  port (
    entr_a, entr_b: in unsigned(15 downto 0);
    sel_op: in unsigned(1 downto 0);
    saida: out unsigned(15 downto 0)
  );
end entity;

architecture arq_ula of ula is
    signal swap: unsigned(15 downto 0);
begin
  swap(15 downto 8) <= entr_a(7 downto 0);
  swap(7 downto 0) <= entr_b(15 downto 8);

  saida <= entr_a + entr_b when sel_op = "00" else
           entr_a - entr_b when sel_op = "01" else
           entr_a and entr_b when sel_op = "10" else
           swap when sel_op = "11" else
           (others=>'0');

end architecture;
