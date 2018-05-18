library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc_pc_rom is
  port (
    clk, rst: in std_logic
  );
end entity;

architecture arq_uc_pc_rom of uc_pc_rom is
  component uc is
    port(
       clk, rst: in std_logic;
       rom_saida: in unsigned(13 downto 0);
       pc_entrada: out unsigned(14 downto 0);
       pc_saida: in unsigned(14 downto 0);
       pc_hab_escr: out std_logic
  );
  end component;

  component pc is
    port(
        clk, rst, hab_escr: in std_logic;
	entrada: in unsigned(14 downto 0);
	saida: out unsigned(14 downto 0)
  );
  end component;

  component rom is
  port (
    clk: in std_logic;
    endereco: in unsigned (14 downto 0);
    dado: out unsigned (13 downto 0)
  );
  end component;
  
  signal pc_hab_escr: std_logic;
  signal rom_saida: unsigned(13 downto 0);
  signal pc_saida, pc_entrada: unsigned(14 downto 0);

begin
  a_uc:
  uc port map(
     clk => clk,
     rst => rst,
     rom_saida => rom_saida,
     pc_entrada => pc_entrada,
     pc_saida => pc_saida,
     pc_hab_escr => pc_hab_escr
  );

  o_pc:
  pc port map(
     clk => clk,
     rst => rst,
     hab_escr => pc_hab_escr,
     entrada => pc_entrada,
     saida => pc_saida
  );

  a_rom:
  rom port map(
     clk => clk,
     endereco => pc_saida,
     dado => rom_saida
  );

end architecture;
