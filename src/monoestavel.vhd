library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity monoestavel is
  port(
    clk, rst: in std_logic;
	entrada: in std_logic;
	saida: out std_logic
  );
end entity;

architecture arq_monoestavel of monoestavel is
signal saida_t: std_logic;
begin
  process(clk, rst)
  begin
    if rst = '1' then
	  saida_t <= '0';
    elsif rising_edge(clk) then
	  if saida_t = '1' then
          saida_t <= '0';
      elsif entrada = '1' then
          saida_t <= '1';
      end if;
	end if;
  end process;

  saida <= saida_t;
end architecture;
