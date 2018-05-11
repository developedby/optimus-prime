library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_teste is
end entity;

architecture arq_rom_teste of rom_teste is
  component rom
    port (
      clk: in std_logic;
      endereco: in unsigned (14 downto 0);
      dado: out unsigned (13 downto 0)
    );
  end component;
  signal clk: std_logic;
  signal endereco: unsigned(14 downto 0);
  signal dado: unsigned(13 downto 0);
begin
unidade_teste:
  rom port map(
    clk => clk,
	endereco => endereco,
	dado => dado
  );
  process
  begin
    clk <= '1';
	wait for 10 ns;
    clk <= '0';
    wait for 10 ns;
  end process;
  
  process
  begin
    endereco <= "000000000000000";
	wait for 20 ns;
	endereco <= "000000000000001";
	wait for 20 ns;
	endereco <= "000000000000010";
	wait for 20 ns;
	endereco <= "000000000000011";
	wait for 20 ns;
	endereco <= "000000000000100";
	wait for 20 ns;
	endereco <= "000000000000101";
	wait for 20 ns;
	endereco <= "000000000000110";
	wait for 20 ns;
	wait;
  end process;
end architecture;
