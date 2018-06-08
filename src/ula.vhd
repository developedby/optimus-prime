library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
  port (
    entr_a, entr_b: in unsigned(15 downto 0);
    sel_op: in unsigned(1 downto 0);
    saida: out unsigned(15 downto 0);
    zero, carry: out unsigned(15 downto 0);
    pula_em: in std_logic;
    pula_instr: out std_logic
  );
end entity;

architecture arq_ula of ula is
    signal swap: unsigned(15 downto 0);
    signal saida_t: unsigned(16 downto 0);
    signal bit_teste: std_logic;
begin
  swap(15 downto 8) <= entr_a(7 downto 0);
  swap(7 downto 0) <= entr_b(15 downto 8);

  saida_t <= (('0' & entr_a) + ('0' & entr_b)) when sel_op = "00" else
           (('0' & entr_a) - ('0' & entr_b)) when sel_op = "01" else
           '0' & swap when sel_op = "11" else
           (others=>'0');

  saida <= saida_t(15 downto 0);

  zero <= (others=>'1') when saida_t = "000000000000000000"
          else (others=>'0');

  carry <= (others=>saida_t(16));

bit_teste <=
    entr_a(0) when entr_b = "0000000000000000" else
    entr_a(1) when entr_b = "0000000000000001" else
    entr_a(2) when entr_b = "0000000000000010" else
    entr_a(3) when entr_b = "0000000000000011" else
    entr_a(4) when entr_b = "0000000000000100" else
    entr_a(5) when entr_b = "0000000000000101" else
    entr_a(6) when entr_b = "0000000000000110" else
    entr_a(7) when entr_b = "0000000000000111" else
    entr_a(8) when entr_b = "0000000000001000" else
    entr_a(9) when entr_b = "0000000000001001" else
    entr_a(10) when entr_b = "0000000000001010" else
    entr_a(11) when entr_b = "0000000000001011" else
    entr_a(12) when entr_b = "0000000000001100" else
    entr_a(13) when entr_b = "0000000000001101" else
    entr_a(14) when entr_b = "0000000000001110" else
    entr_a(15) when entr_b = "0000000000001111" else '0';

 pula_instr <= '1' when
            (sel_op = "10") and (bit_teste xnor pula_em) = '1'
            else '0';
end architecture;
