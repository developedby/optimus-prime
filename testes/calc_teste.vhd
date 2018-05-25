library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calc_teste is
end entity;

architecture calc_teste of calc_teste is
  component calc is
    port (
      clk, rst: in std_logic
    );
  end component;

  signal clk, rst: std_logic;

begin
  unidade_teste:
  calc port map(
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
