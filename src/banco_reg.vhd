library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_reg is
  port(
    sel_reg_l1: in unsigned(2 downto 0);
    sel_reg_l2: in unsigned(2 downto 0);
    sel_reg_e: in unsigned(2 downto 0);
    entr_dados: in unsigned(15 downto 0);
    hab_escr: in std_logic;
    clk: in std_logic;
    rst: in std_logic;
    saida_dados1: out unsigned(15 downto 0);
    saida_dados2: out unsigned(15 downto 0)
  );
end entity;

architecture arq_banco_reg of banco_reg is
  component reg16bit is
    port(
      clk, rst, hab_escr: in std_logic;
	  entrada: in unsigned(15 downto 0);
	  saida: out unsigned(15 downto 0)
    );
  end component;
  signal hab_reg_escr: std_logic(7 downto 0);
begin
  registradores:
  for i in 0 to 7 generate
    reg_zero:
	if i = 0 generate
	  reg0: reg16bit port map ( --lembrar como é isso aqui
	    clk => clk,
		rst => '1',
		hab_escr => hab_reg_escr,
		entrada_reg(i) => entrada,
		saida_reg(i) => saida
	  );
	end generate reg_zero;
	outros_regs:
	if i > 0 generate
	  regX: reg16bit port map (
	    clk => clk,
		rst => rst,
		hab_escr => hab_reg_escr,
		entrada_reg(i) => entrada,
		saida_reg(i) => saida
	  );
	end generate outros_regs;
  end generate registradores;

  saida_dados1 <= saida_reg(sel_reg_l1);
  saida_dados2 <= saida_reg(sel_reg_l2);
  
  hab_reg_escr(0) <= hab_escr when sel_reg_e = "000" else '0';
  hab_reg_escr(1) <= hab_escr when sel_reg_e = "001" else '0';
  hab_reg_escr(2) <= hab_escr when sel_reg_e = "010" else '0';
  hab_reg_escr(3) <= hab_escr when sel_reg_e = "011" else '0';
  hab_reg_escr(4) <= hab_escr when sel_reg_e = "100" else '0';
  hab_reg_escr(5) <= hab_escr when sel_reg_e = "101" else '0';
  hab_reg_escr(6) <= hab_escr when sel_reg_e = "110" else '0';
  hab_reg_escr(7) <= hab_escr when sel_reg_e = "111" else '0';
  