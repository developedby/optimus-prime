library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- RAM
-- Memória de dados de acesso indireto com 2^16 words de 16 bits

entity ram is
 port(
 clk : in std_logic;
 endereco : in unsigned(15 downto 0);
 hab_escr : in std_logic;
 entr_dado : in unsigned(15 downto 0);
 saida_dado : out unsigned(15 downto 0)
 );
end entity;

architecture arq_ram of ram is
 type mem is array (0 to 65535) of unsigned(15 downto 0);
 signal conteudo_ram : mem;
begin
 process(clk,wr_en)
 begin
	if rising_edge(clk) then
		if wr_en='1' then
			conteudo_ram(to_integer(endereco)) <= dado_in;
		end if;
	end if;
 end process;
 dado_out <= conteudo_ram(to_integer(endereco));
end architecture;
