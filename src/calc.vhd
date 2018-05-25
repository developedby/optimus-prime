library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calc is
  port (
    clk, rst: in std_logic
  );
end entity;

architecture arq_calc of calc is
component uc is
  port(
    clk, rst: in std_logic;
    rom_saida: in unsigned(13 downto 0);
    pc_entrada: out unsigned(14 downto 0);
    pc_saida: in unsigned(14 downto 0);
    pc_hab_escr: out std_logic;
    ula_op: out unsigned(1 downto 0);
    reg_le_1, reg_le_2, reg_escr: out unsigned(6 downto 0);
    orig_ula_1: out unsigned(1 downto 0);
    orig_ula_2: out unsigned(1 downto 0);
    br_hab_escr: out std_logic
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

component ula is
  port (
    entr_a, entr_b: in unsigned(15 downto 0);
    sel_op: in unsigned(1 downto 0);
    saida: out unsigned(15 downto 0)
  );
end component;

component banco_reg is
  port(
    sel_reg_le1: in unsigned(6 downto 0);
    sel_reg_le2: in unsigned(6 downto 0);
    sel_reg_escr: in unsigned(6 downto 0);
    entr_dados: in unsigned(15 downto 0);
    hab_escr: in std_logic;
    clk: in std_logic;
    rst: in std_logic;
    saida_dados1: out unsigned(15 downto 0);
    saida_dados2: out unsigned(15 downto 0)
  );
end component;

signal pc_hab_escr: std_logic;
signal rom_saida: unsigned(13 downto 0);
signal pc_saida, pc_entrada: unsigned(14 downto 0);

signal entr_ula_1, entr_ula_2: unsigned(15 downto 0);
signal ula_op: unsigned(1 downto 0);
signal saida_ula: unsigned(15 downto 0);
signal reg_le_1, reg_le_2, reg_escr: unsigned(6 downto 0);
signal orig_ula_1: unsigned(1 downto 0);
signal orig_ula_2: unsigned(1 downto 0);
signal br_hab_escr: std_logic;

signal saida_br_1, saida_br_2: unsigned(15 downto 0);

begin
a_uc:
uc port map(
   clk => clk,
   rst => rst,
   rom_saida => rom_saida,
   pc_entrada => pc_entrada,
   pc_saida => pc_saida,
   pc_hab_escr => pc_hab_escr,
   ula_op => ula_op,
   reg_le_1 => reg_le_1,
   reg_le_2 => reg_le_2,
   reg_escr => reg_escr,
   orig_ula_1 => orig_ula_1,
   orig_ula_2 => orig_ula_2,
   br_hab_escr => br_hab_escr
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

a_ula:
ula port map(
    entr_a => entr_ula_1,
    entr_b => entr_ula_2,
    sel_op => ula_op,
    saida => saida_ula
);

o_banco_reg:
banco_reg port map(
    sel_reg_le1 => reg_le_1,
    sel_reg_le2 => reg_le_2,
    sel_reg_escr => reg_escr,
    entr_dados => saida_ula,
    hab_escr => br_hab_escr,
    clk => clk,
    rst => rst,
    saida_dados1 => saida_br_1,
    saida_dados2 => saida_br_2
);

entr_ula_1(7 downto 0) <= saida_br_1(7 downto 0) when orig_ula_1 = "00" else
              rom_saida(7 downto 0) when orig_ula_1 = "01" else
              (others=>'0');

entr_ula_1(15 downto 8) <= saida_br_1(15 downto 8) when orig_ula_1 = "00" else
              (others=>rom_saida(7)) when orig_ula_1 = "01" else
              (others=>'0');

entr_ula_2 <= saida_br_2 when orig_ula_2 = "00" else
            "0000000000000000" when orig_ula_2 = "01" else
            (others=>'0');

end architecture;
