library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_com_banco_reg is
  port (
    entr_ext_ula: in unsigned(15 downto 0);
    sel_op_ula: in unsigned(1 downto 0);
    clk, rst, hab_escr, sel_orig: in std_logic;
    saida: out unsigned(15 downto 0);
    entr_iguais_ula, a_maior_b_ula, a_menor_b_ula: out std_logic;
  );
end entity;

architecture arq_ula_com_banco_reg of ula_com_banco_reg is
  component ula is
    port(
      entr_a, entr_b: in unsigned(15 downto 0);
      sel_op: in unsigned(1 downto 0);
      saida: out unsigned(15 downto 0);
      entr_iguais, a_maior_b, a_menor_b: out std_logic
      );
  end component;
  component banco_reg is
  port (
    sel_reg_le1: in unsigned(2 downto 0);
    sel_reg_le2: in unsigned(2 downto 0);
    sel_reg_escr: in unsigned(2 downto 0);
    entr_dados: in unsigned(15 downto 0);
    hab_escr: in std_logic;
    clk: in std_logic;
    rst: in std_logic;
    saida_dados1: out unsigned(15 downto 0);
    saida_dados2: out unsigned(15 downto 0)
  );
  end component;
  
  signal sel_reg_le1: unsigned(2 downto 0);
  signal sel_reg_le2: unsigned(2 downto 0);
  signal sel_reg_escr: unsigned(2 downto 0);
  signal entr_dados_banco: unsigned(15 downto 0);
  signal saida_banco1: unsigned(15 downto 0);
  signal saida_banco2: unsigned(15 downto 0);
  signal entr_ula1: unsigned(15 downto 0);
  signal entr_ula2: unsigned(15 downto 0);
  signal saida_ula: unsigned(15 downto 0);
  signal mux_ula_entr1: unsigned (15 downto 0);
  signal mux_ula_entr2: unsigned (15 downto 0);
  signal mux_ula_saida: unsigned (15 downto 0);

begin
  ula:
  ula port map(
    entr_a => entr_ula1,
    entr_b => entr_ula2,
    sel_op => sel_op_ula,
    saida => saida_ula,
    entr_iguais => entr_iguais_ula,
    a_maior_b => a_maior_b_ula,
    a_menor_b => a_menor_b_ula
  )

  banco_reg:
  banco_reg port map(
    sel_reg_le1 => sel_reg_le1,
    sel_reg_le2 => sel_reg_le2,
    sel_reg_escr => sel_reg_escr,
    entr_dados => entr_dados_banco,
    hab_escr => hab_escr,
    clk => clk,
    rst => rst,
    saida_dados1 => saida_banco1,
    saida_dados2 => saida_banco2
  )

  --Ligando sinais nos outros
  entr_dados_banco <= saida_ula;
  entr_ula1 <= saida_banco1;
  entr_ula2 <= mux_ula_saida;
  mux_ula_entr1 <= saida_banco2;
  mux_ula_entr2 <= entr_ext_ula;

  -- Mux de selecao da ULA
  mux_ula_saida <= mux_ula_entr1 when sel_orig = '0' else
                   mux_ula_entr2 when sel_orig = '1' else
                   (others=>'0');

end architecture;
