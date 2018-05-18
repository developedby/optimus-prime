library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ff_t is
  port(
     clk, rst: in std_logic;
     saida: out std_logic
  );
end entity;

architecture arq_ff_t of ff_t is
signal estado: std_logic;
begin
  process(clk, rst)
  begin
    if rst = '1' then
	  estado <= '0';
    elsif rising_edge(clk) then
	  estado <= not estado;
    end if;
  end process;

saida <= estado;

end architecture;
