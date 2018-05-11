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
    0 => "01001010000010",
	1 => "00000000000011",
	2 => "00000000000001",
	3 => "11111011110100",
	4 => "00111111111111",
	5 => "00000000011111",
	6 => "00000111111101",
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