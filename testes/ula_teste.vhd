library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_teste is
end entity;

architecture arq_ula_teste of ula_teste is
  component ula
    port (
      entr_a, entr_b: in unsigned(15 downto 0);
      sel_op: in unsigned(1 downto 0);
      saida: out unsigned(15 downto 0);
      entr_iguais, a_maior_b, a_menor_b: out std_logic
    );
  end component;
  signal entr_a, entr_b, saida: unsigned(15 downto 0);
  signal sel_op: unsigned(1 downto 0);
  signal entr_iguais, a_maior_b, a_menor_b: std_logic;
begin
unidade_teste:
  ula port map(
    entr_a => entr_a,
    entr_b => entr_b,
    sel_op => sel_op,
    saida => saida,
    entr_iguais => entr_iguais,
    a_maior_b => a_maior_b,
    a_menor_b => a_menor_b
  );
  process
  begin
    entr_a <= "0000000010101101";
    entr_b <= "0000000000100101";
    sel_op <= "00";
    wait for 100 ns;
    sel_op <= "01";
    wait for 100 ns;
    sel_op <= "10";
    wait for 100 ns;
    sel_op <= "11";
    wait for 100 ns;

    entr_a <= "1100101101011101";
    entr_b <= "1101011011010010";
    sel_op <= "00";
    wait for 100 ns;
    sel_op <= "01";
    wait for 100 ns;
    sel_op <= "10";
    wait for 100 ns;
    sel_op <= "11";
    wait for 100 ns;

    entr_a <= "1100101101011101";
    entr_b <= "0000000000000000";
    sel_op <= "00";
    wait for 100 ns;
    sel_op <= "01";
    wait for 100 ns;
    sel_op <= "10";
    wait for 100 ns;
    sel_op <= "11";
    wait for 100 ns;

    entr_a <= "0000000000000000";
    entr_b <= "1101011011010010";
    sel_op <= "00";
    wait for 100 ns;
    sel_op <= "01";
    wait for 100 ns;
    sel_op <= "10";
    wait for 100 ns;
    sel_op <= "11";
    wait for 100 ns;

    entr_a <= "0000000000000000";
    entr_b <= "0000000000000000";
    sel_op <= "00";
    wait for 100 ns;
    sel_op <= "01";
    wait for 100 ns;
    sel_op <= "10";
    wait for 100 ns;
    sel_op <= "11";
    wait for 100 ns;
    wait;
  end process;
end architecture;
