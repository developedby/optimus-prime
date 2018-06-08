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
        0 =>  "11000000000000", --MOVLW 0;
        1 =>  "00000010000101", --MOVWF 5;
        2 =>  "11000000000000", --MOVLW 0;
        3 =>  "00000010000110", --MOVWF 6;
        4 =>  "00100000000101", --MOVF 5,W;
        5 =>  "00011110000110", --ADDWF 6,F;
        6 =>  "11000000000001", --MOVLW 1;
        7 =>  "00011110000101", --ADDWF 5,F;
        8 =>  "11000000011110", --MOVLW 30;
        9 =>  "00001000000101", --SUBWFB 5,W;
        10 => "01000000000001", --BTFSC W,0;
        11 => "11001111111001", --BRA -7;
        12 => "00100000000110", --MOVF 6,W;
        13 => "00000010000111", --MOVWF 7;
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
