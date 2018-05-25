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
        0 =>  "11000000000101", --MOVLW 5;
        1 =>  "00000010000011", --MOVWF 3;
        2 =>  "11000000001000", --MOVLW 8;
        3 =>  "00000010000100", --MOVWF 4;
        4 =>  "00100000000011", --MOVF W,3;
        5 =>  "00011100000100", --ADDWF W,4;
        6 =>  "00000010000101", --MOVWF 5;
        7 =>  "11000000000001", --MOVLW 1;
        8 =>  "00001010000101", --SUBWFB F,5;
        9 =>  "10100000010100", --GOTO 20;
        20 => "00100000000101", --MOVF W,5;
        21 => "00000010000011", --MOVWF 3
        22 => "10100000000100", --GOTO 4
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
