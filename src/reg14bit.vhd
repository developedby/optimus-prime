library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg14bit is
  port(
    clk, rst, hab_escr: in std_logic;
	entrada: in unsigned(13 downto 0);
	saida: out unsigned(13 downto 0)
  );
end entity;

architecture arq_reg14bit of reg14bit is
begin
  process(clk, rst)
  begin
    if rst = '1' then
	  saida <= (others => '0');
	elsif hab_escr = '1' and rising_edge(clk) then
	  saida <= entrada;
	end if;
  end process;
end architecture;
