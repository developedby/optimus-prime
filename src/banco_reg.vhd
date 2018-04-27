library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_reg is
  port(
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
end entity;

architecture arq_banco_reg of banco_reg is
  component reg16bit is
    port(
      clk, rst, hab_escr: in std_logic;
	  entrada: in unsigned(15 downto 0);
	  saida: out unsigned(15 downto 0)
    );
  end component;
  type std_logic_array_8bit is array(7 downto 0) of std_logic;
  signal hab_reg_escr: std_logic_array_8bit;
  type unsigned_array_8x16 is array(7 downto 0) of unsigned(15 downto 0);
  signal saida_reg: unsigned_array_8x16;
begin
  registradores:
  for i in 0 to 7 generate
    reg_zero:
	if i = 0 generate
	  reg0: reg16bit port map (
	    clk => clk,
		rst => '1',
		hab_escr => hab_reg_escr(i),
		entrada => entr_dados,
		saida => saida_reg(i)
	  );
	end generate reg_zero;
	outros_regs:
	if i > 0 generate
	  regX: reg16bit port map (
	    clk => clk,
		rst => rst,
		hab_escr => hab_reg_escr(i),
		entrada => entr_dados,
		saida => saida_reg(i)
	  );
	end generate outros_regs;
  end generate registradores;

  saida_dados1 <= saida_reg(0) when sel_reg_le1 = "000" else
                  saida_reg(1) when sel_reg_le1 = "001" else
			      saida_reg(2) when sel_reg_le1 = "010" else
			      saida_reg(3) when sel_reg_le1 = "011" else
			      saida_reg(4) when sel_reg_le1 = "100" else
			      saida_reg(5) when sel_reg_le1 = "101" else
			      saida_reg(6) when sel_reg_le1 = "110" else
			      saida_reg(7) when sel_reg_le1 = "111" else
			      (others=>'0');
  saida_dados2 <= saida_reg(0) when sel_reg_le2 = "000" else
                  saida_reg(1) when sel_reg_le2 = "001" else
			      saida_reg(2) when sel_reg_le2 = "010" else
			      saida_reg(3) when sel_reg_le2 = "011" else
			      saida_reg(4) when sel_reg_le2 = "100" else
			      saida_reg(5) when sel_reg_le2 = "101" else
			      saida_reg(6) when sel_reg_le2 = "110" else
			      saida_reg(7) when sel_reg_le2 = "111" else
			      (others=>'0');
  
  hab_reg_escr(0) <= hab_escr when sel_reg_escr = "000" else '0';
  hab_reg_escr(1) <= hab_escr when sel_reg_escr = "001" else '0';
  hab_reg_escr(2) <= hab_escr when sel_reg_escr = "010" else '0';
  hab_reg_escr(3) <= hab_escr when sel_reg_escr = "011" else '0';
  hab_reg_escr(4) <= hab_escr when sel_reg_escr = "100" else '0';
  hab_reg_escr(5) <= hab_escr when sel_reg_escr = "101" else '0';
  hab_reg_escr(6) <= hab_escr when sel_reg_escr = "110" else '0';
  hab_reg_escr(7) <= hab_escr when sel_reg_escr = "111" else '0';
end architecture;