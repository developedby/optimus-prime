library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc_pc_rom_teste is
end entity;

architecture arq_uc_pc_rom_teste of uc_pc_rom_teste is
  component uc_pc_rom is
    port (
      clk, rst: in std_logic
    );
  end component;

  signal clk, rst: std_logic;

  begin
  unidade_teste: 
  uc_pc_rom port map(
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
