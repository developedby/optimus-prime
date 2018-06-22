library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Processador
-- Top-level com todos os componentes
-- Implementa as mux de entradas e saídas dos componentes

entity processador is
  port (
    clk, rst: in std_logic
  );
end entity;

architecture arq_processador of processador is
component uc is
  port(
    clk, rst: in std_logic;
    rom_saida: in unsigned(13 downto 0);
    orig_pc: out std_logic;
    pc_hab_escr: out std_logic;
    ula_op: out unsigned(1 downto 0);
    reg_le_1, reg_le_2, reg_escr: out unsigned(6 downto 0);
    orig_ula_1: out unsigned(1 downto 0);
    orig_ula_2: out unsigned(1 downto 0);
    br_hab_escr: out std_logic;
    hab_escr_z, hab_escr_c: out std_logic;
    pula_em: out std_logic;
    pula_instr_ula: in std_logic;
	hab_escr_ram: out std_logic;
	orig_br: out std_logic
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
    saida: out unsigned(15 downto 0);
    zero, carry: out unsigned(15 downto 0);
    pula_em: in std_logic;
    pula_instr: out std_logic
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
    saida_dados2: out unsigned(15 downto 0);
    entr_z, entr_c: in unsigned(15 downto 0);
    hab_escr_z, hab_escr_c: in std_logic
  );
end component;

component ram is
 port(
 clk : in std_logic;
 endereco : in unsigned(15 downto 0);
 hab_escr : in std_logic;
 entr_dado : in unsigned(15 downto 0);
 saida_dado : out unsigned(15 downto 0)
 );
end component;

signal pc_hab_escr: std_logic;
signal rom_saida: unsigned(13 downto 0);
signal pc_saida, pc_entrada: unsigned(14 downto 0);
signal orig_pc: std_logic;

signal entr_ula_1, entr_ula_2: unsigned(15 downto 0);
signal ula_op: unsigned(1 downto 0);
signal saida_ula: unsigned(15 downto 0);
signal reg_le_1, reg_le_2, reg_escr: unsigned(6 downto 0);
signal orig_ula_1: unsigned(1 downto 0);
signal orig_ula_2: unsigned(1 downto 0);
signal br_hab_escr: std_logic;

signal entr_br, saida_ram, saida_br_1, saida_br_2: unsigned(15 downto 0);

signal zero, carry: unsigned(15 downto 0);
signal hab_escr_z, hab_escr_c: std_logic;

signal pula_em: std_logic;
signal pula_instr: std_logic;

signal hab_escr_ram: std_logic;
signal orig_br: std_logic;

begin
a_uc:
uc port map(
   clk => clk,
   rst => rst,
   rom_saida => rom_saida,
   orig_pc => orig_pc,
   pc_hab_escr => pc_hab_escr,
   ula_op => ula_op,
   reg_le_1 => reg_le_1,
   reg_le_2 => reg_le_2,
   reg_escr => reg_escr,
   orig_ula_1 => orig_ula_1,
   orig_ula_2 => orig_ula_2,
   br_hab_escr => br_hab_escr,
   pula_em => pula_em,
   pula_instr_ula => pula_instr,
   hab_escr_z => hab_escr_z,
   hab_escr_c => hab_escr_c,
   hab_escr_ram => hab_escr_ram,
   orig_br => orig_br
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
    saida => saida_ula,
    zero => zero,
    carry => carry,
    pula_em => pula_em,
    pula_instr => pula_instr
);

o_banco_reg:
banco_reg port map(
    sel_reg_le1 => reg_le_1,
    sel_reg_le2 => reg_le_2,
    sel_reg_escr => reg_escr,
    entr_dados => entr_br,
    hab_escr => br_hab_escr,
    clk => clk,
    rst => rst,
    saida_dados1 => saida_br_1,
    saida_dados2 => saida_br_2,
    entr_z => zero,
    entr_c => carry,
    hab_escr_z => hab_escr_z,
    hab_escr_c => hab_escr_c
);

a_ram:
ram port map(
 clk => clk,
 endereco => saida_br_1,
 hab_escr => hab_escr_ram,
 entr_dado => saida_br_2,
 saida_dado => saida_ram
 );

-- Soma 1 no PC ou jump
pc_entrada <= saida_ula(14 downto 0) when orig_pc = '0' else
              pc_saida + 1;

-- Mux de seleção de entrada da ULA
entr_ula_1 <= saida_br_1 when orig_ula_1 = "00" else --reg
              "00000000" & rom_saida(7 downto 0)
              when orig_ula_1 = "01" else --constante
              '0' & pc_saida
              when orig_ula_1 = "10" else --pc
              '0' & pc_saida(14 downto 11) & rom_saida(10 downto 0)
              when orig_ula_1 = "11" else --constante GOTO
              (others=>'0');

entr_ula_2 <= saida_br_2 when orig_ula_2 = "00" else --reg
            "0000000000000000" when orig_ula_2 = "01" else --constante 0
            rom_saida(8) & rom_saida(8) & rom_saida(8) & rom_saida(8) & rom_saida(8) & rom_saida(8) & rom_saida(8) & rom_saida(8 downto 0)
            when orig_ula_2 = "10" else --constante BRA
            "000000000000" & rom_saida(10 downto 7)
            when orig_ula_2 = "11" else --bit para testar
            (others=>'0');

-- Mux entrada banco de registradores
entr_br <= saida_ula when orig_br = '0' else
			saida_ram when orig_br = '1' else (others=>'0');

end architecture;
