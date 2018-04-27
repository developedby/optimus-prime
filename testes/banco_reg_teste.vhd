library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_reg_teste is
end entity;

architecture arq_banco_reg_teste of banco_reg_teste is
  component banco_reg is
    port(
      sel_reg_le1: in unsigned(2 downto 0);
      sel_reg_le2: in unsigned(2 downto 0);
      sel_reg_escr: in unsigned(2 downto 0);
      entr_dados: in unsigned(15 downto 0);
      hab_escr: in std_logic;
      clk: in std_logic;
      rst: in std_logic;
      saida_dados1: out unsigned(15 downto 0);
      saida_dados2: out unsigned(15 downto 0)
    );
  end component;
  signal sel_reg_le1, sel_reg_le2, sel_reg_escr: unsigned(2 downto 0);
  signal entr_dados, saida_dados1, saida_dados2: unsigned(15 downto 0);
  signal hab_escr, clk, rst: std_logic;
begin
unidade_teste: 
  banco_reg port map(
    sel_reg_le1 => sel_reg_le1,
	sel_reg_le2 => sel_reg_le2,
	sel_reg_escr => sel_reg_escr, 
	entr_dados => entr_dados, 
	hab_escr => hab_escr,
	clk => clk,
	rst => rst,
    saida_dados1 => saida_dados1,
	saida_dados2 => saida_dados2
  );
  process
  begin
    clk <= '0';
	wait for 19 ns;
	clk <= '1';
	wait for 18 ns;
  end process;
  
  process
  begin
    rst <= '1';
    sel_reg_le1 <= "000";
	sel_reg_le2 <= "000";
	sel_reg_escr <= "000";
	entr_dados <= "0000000000000000";
	hab_escr <= '0';
	wait for 35 ns;
	
	rst <= '0';
	wait for 7 ns;
	
	sel_reg_le1 <= "110";
	sel_reg_le2 <= "001";
	sel_reg_escr <= "010";
	entr_dados <= "1000100001000010";
	hab_escr <= '1';
	wait for 31 ns;
	
	sel_reg_le1 <= "010";
	sel_reg_le2 <= "101";
	sel_reg_escr <= "011";
	entr_dados <= "0101000100010111";
	wait for 31 ns;
	
	sel_reg_le1 <= "010";
	sel_reg_le2 <= "011";
	sel_reg_escr <= "000";
	entr_dados <= "0010001111000000";
	wait for 31 ns;
	
	sel_reg_le1 <= "000";
	sel_reg_le2 <= "111";
	sel_reg_escr <= "111";
	entr_dados <= "0011100010111010";
	wait for 31 ns;
	
    rst <= '1';
	wait for 10 ns;
	rst <= '0';
	wait for 2 ns;
	
	sel_reg_le1 <= "001";
	sel_reg_le2 <= "010";
	sel_reg_escr <= "000";
	entr_dados <= "0000000000000000";
	hab_escr <= '1';
	wait for 31 ns;
	
	sel_reg_le1 <= "111";
	sel_reg_le2 <= "011";
	sel_reg_escr <= "000";
	entr_dados <= "0000000000000000";
	hab_escr <= '1';
	wait for 31 ns;
	
	sel_reg_le1 <= "001";
	sel_reg_le2 <= "001";
	sel_reg_escr <= "001";
	entr_dados <= "1111111111111110";
	hab_escr <= '0';
	wait for 31 ns;
	
	sel_reg_le1 <= "001";
	sel_reg_le2 <= "011";
	sel_reg_escr <= "000";
	entr_dados <= "0000000000000000";
	hab_escr <= '1';
	wait for 31 ns;
	wait;
  end process;
end architecture;