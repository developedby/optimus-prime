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

  saida_t <= entr_a + entr_b when sel_op = "00" else
           entr_a - entr_b when sel_op = "01" else
           swap when sel_op = "11" else
           (others=>'0');

  saida <= saida_t(15 downto 0);

  zero <= (others=>'1') when saida_t = (others=>'0')
          else (others=>'0');

  carry <= (others=>saida_t(16));

bit_teste <=
    entr_a(0) when entr_b = "0000000000000000" else
    entr_a(1) when entr_b = "0000000000000000" else
    entr_a(2) when entr_b = "0000000000000000" else
    entr_a(3) when entr_b = "0000000000000000" else
    entr_a(4) when entr_b = "0000000000000000" else
    entr_a(5) when entr_b = "0000000000000000" else
    entr_a(6) when entr_b = "0000000000000000" else
    entr_a(7) when entr_b = "0000000000000000" else
    entr_a(8) when entr_b = "0000000000000000" else
    entr_a(9) when entr_b = "0000000000000000" else
    entr_a(10) when entr_b = "0000000000000000" else
    entr_a(11) when entr_b = "0000000000000000" else
    entr_a(12) when entr_b = "0000000000000000" else
    entr_a(13) when entr_b = "0000000000000000" else
    entr_a(14) when entr_b = "0000000000000000" else
    entr_a(15) when entr_b = "0000000000000000" else
    (others => '0');

 pula_instr <= '1' when
            sel_op = "10" and (bit_teste xnor pula_em);
end architecture;
