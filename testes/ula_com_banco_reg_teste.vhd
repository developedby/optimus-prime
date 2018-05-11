library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_com_banco_reg_teste is
end entity;

architecture arq_ula_com_banco_reg_teste of ula_com_banco_reg_teste is
  component ula_com_banco_reg is
    port (
      sel_reg_le1, sel_reg_le2, sel_reg_escr: in unsigned(2 downto 0);
      entr_ext_ula: in unsigned(15 downto 0);
      sel_op_ula: in unsigned(1 downto 0);
      clk, rst, hab_escr, sel_orig: in std_logic;
      saida: out unsigned(15 downto 0);
      entr_iguais_ula, a_maior_b_ula, a_menor_b_ula: out std_logic
    );
  end component;

  signal sel_reg_le1, sel_reg_le2, sel_reg_escr: unsigned(2 downto 0);
  signal entr_ext_ula: unsigned(15 downto 0);
  signal sel_op_ula: unsigned(1 downto 0);
  signal clk, rst, hab_escr, sel_orig: std_logic;
  signal saida: unsigned(15 downto 0);
  signal entr_iguais_ula, a_maior_b_ula, a_menor_b_ula: std_logic;

  begin
  unidade_teste: 
  ula_com_banco_reg port map(
      sel_reg_le1 => sel_reg_le1,
      sel_reg_le2 => sel_reg_le2,
      sel_reg_escr => sel_reg_escr,
      entr_ext_ula => entr_ext_ula,
      sel_op_ula => sel_op_ula, 
      clk => clk,
      rst => rst,
      hab_escr => hab_escr,
      sel_orig => sel_orig,
      saida => saida,
      entr_iguais_ula => entr_iguais_ula,
      a_maior_b_ula => a_maior_b_ula,
      a_menor_b_ula => a_menor_b_ula
  );
  process
  begin
    clk <= '0';
    wait for 18 ns;
    clk <= '1';
    wait for 18 ns;
  end process;
  
  process
  begin
    rst <= '1';
    wait for 10 ns;
    rst <= '0';
    wait for 5 ns;

    sel_orig <= '1';
    entr_ext_ula <= "0000000000011111";
    sel_op_ula <= "00";
    hab_escr <= '1';
    sel_reg_le1 <= "000";
    sel_reg_le2 <= "001";
    sel_reg_escr <= "001";
    wait for 36 ns;

    hab_escr <= '1';
    sel_orig <= '0';
    sel_reg_le1 <= "001";
    sel_reg_le2 <= "001";
    sel_reg_escr <= "010";
    sel_op_ula <= "10";
    wait for 36 ns;

    hab_escr <= '0';
    sel_orig <= '1';
    entr_ext_ula <= "0000000000011111";
    sel_reg_le1 <= "010";
    sel_reg_le2 <= "001";
    sel_reg_escr <= "011";
    sel_op_ula <= "01";
    wait for 36 ns;
    
    rst <= '1';
    wait for 10 ns;
    rst <= '0';
    wait for 5 ns;
    wait;
  end process;
end architecture;
