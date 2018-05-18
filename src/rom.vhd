library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
  port (
   clk: in std_logic;
   endereco: in unsigned (14 downto 0);
   dado: out unsigned (13 downto 0)
   );
 end entity;
 
architecture arq_rom of rom is
  type mem_prog is array (0 to 32767) of unsigned (13 downto 0);
  constant dados_rom : mem_prog := (
        0 => "00000000000000",
	1 => "00000000000001",
	2 => "00000000000010",
	3 => "10100000000101",
	4 => "10100000000000",
	5 => "00000000000101",
	6 => "00000000000110",
        7 => "00000000000111",
        8 => "10100000000101",
    others => (others => '0')
  );  
begin
  process(clk)
  begin 
    if rising_edge(clk) then
	  dado <= dados_rom(to_integer(endereco));
	end if;
  end process;
end architecture;
