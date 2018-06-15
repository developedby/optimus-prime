library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Teste do processador
-- Executa as intruções da ROM até o stop-time

entity processador_teste is
end entity;

architecture processador_teste of processador_teste is
  component processador is
    port (
      clk, rst: in std_logic
    );
  end component;

  signal clk, rst: std_logic;

begin
  unidade_teste:
  processador port map(
      clk => clk,
      rst => rst
  );

  process
  begin
    clk <= '0';
    wait for 17 ns;
    clk <= '1';
    wait for 17 ns;
  end process;

  process
  begin
    rst <= '1';
    wait for 3 ns;
    rst <= '0';
    wait;
  end process;
end architecture;
