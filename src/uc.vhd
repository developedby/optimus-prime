library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc is
  port(
     clk, rst: in std_logic;
     rom_saida: in unsigned(13 downto 0);
     pc_entrada: out unsigned(14 downto 0);
     pc_saida: in unsigned(14 downto 0);
     pc_hab_escr: out std_logic
  );
end entity;

architecture arq_uc of uc is
signal estado: std_logic;
signal instrucao: unsigned(13 downto 0);

component ff_t is
  port(
    clk, rst: in std_logic;
	saida: out std_logic
  );
end component;

begin
  maq_estado: ff_t port map (
	    clk => clk,
	    rst => rst,
            saida => estado
	  );

  instrucao <= rom_saida when estado = '0' else
               instrucao;

  pc_entrada(10 downto 0) <= instrucao(10 downto 0) when instrucao(13 downto 11) = "101" else
			     pc_saida(10 downto 0) + "00000000001";
  pc_entrada(14 downto 11) <= pc_saida(14 downto 11) + "0001" when instrucao(13 downto 11) /= "101" and pc_saida(10 downto 0) = "11111111111" else
                             pc_saida(14 downto 11);
  pc_hab_escr <= estado;

end architecture;
