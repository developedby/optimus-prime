library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg16bit_teste is
end entity;

architecture arq_reg16bit_teste of reg16bit_teste is
  component reg16bit is
    port(
      clk, rst, hab_escr: in std_logic;
  	  entrada: in unsigned(15 downto 0);
      saida: out unsigned(15 downto 0)
    );
	end component;
  signal entrada, saida: unsigned(15 downto 0);
  signal rst, clk, hab_escr: std_logic;
begin
unidade_teste:
  reg16bit port map (
    clk => clk,
	rst => rst,
	hab_escr => hab_escr,
	entrada => entrada,
	saida => saida
  );
  process
  begin
    clk <= '0';
    wait for 10 ns;
	clk <= '1';
	wait for 10 ns;
  end process;
  
  process
  begin
    rst <= '0';
    hab_escr <= '1';
    entrada <= "1001011010010110";
	wait for 37 ns;
	entrada <= "0001011010110101";
	wait for 20 ns;
	rst  <= '1';
	wait for 5 ns;
	rst <= '0';
	wait for 36 ns;
	hab_escr <= '0';
	wait for 8 ns;
	entrada <= "0001011010110101";
	wait;
  end process;
end architecture;