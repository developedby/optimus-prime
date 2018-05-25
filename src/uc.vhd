library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc is
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

  --GOTO ou incrementa PC
  pc_entrada(10 downto 0) <= instrucao(10 downto 0) when instrucao(13 downto 11) = "101" else
                             pc_saida(10 downto 0) + "00000000001";
  pc_entrada(14 downto 11) <= pc_saida(14 downto 11) + "0001" when instrucao(13 downto 11) /= "101" and pc_saida(10 downto 0) = "11111111111" else
                             pc_saida(14 downto 11);
  pc_hab_escr <= estado;

    --BRA
    --when instrucao(13 downto 10) = "1100"

  ula_op <= "00" when
            instrucao(13 downto 8) = "000111" or
            instrucao(13 downto 8) = "001000" or
            instrucao(13 downto 7) = "0000001" or
            instrucao(13 downto 8) = "111110"
            else "01" when
            instrucao(13 downto 7) = "0000011" or
            instrucao(13 downto 7) = "0000010" or
            instrucao(13 downto 8) = "000010" or
            instrucao(13 downto 8) = "111100"
            else "11" when
            instrucao(13 downto 8) = "001110"
            else (others=>'0');


  reg_le_1 <= "0000000" when
               instrucao(13 downto 7) = "0000010" or
               instrucao(13 downto 7) = "0000001"
               else instrucao(6 downto 0) when
               instrucao(13 downto 8) = "000111" or
               instrucao(13 downto 7) = "0000011" or
               instrucao(13 downto 8) = "001000" or
               instrucao(13 downto 8) = "000010" or
               instrucao(13 downto 8) = "001110"
               else (others=>'0');

    reg_le_2 <= "0000000" when
                instrucao(13 downto 8) = "000111" or
                instrucao(13 downto 7) = "0000010" or
                instrucao(13 downto 8) = "000010" or
                instrucao(13 downto 8) = "111110" or
                instrucao(13 downto 8) = "111100"
                else instrucao(6 downto 0) when
                instrucao(13 downto 7) = "0000011" or
                instrucao(13 downto 8) = "001110"
                else (others=>'0');

  orig_ula_1 <= "00" when
                instrucao(13 downto 8) = "000111" or
                instrucao(13 downto 7) = "0000011" or
                instrucao(13 downto 7) = "0000010" or
                instrucao(13 downto 8) = "001000" or
                instrucao(13 downto 7) = "0000001" or
                instrucao(13 downto 8) = "000010" or
                instrucao(13 downto 8) = "001110"
                else "01" when
                instrucao(13 downto 8) = "111110" or
                instrucao(13 downto 8) = "110000" or
                instrucao(13 downto 8) = "111100"
                else (others=>'0');

    orig_ula_2 <= "00" when
                  instrucao(13 downto 8) = "000111" or
                  instrucao(13 downto 7) = "0000011" or
                  instrucao(13 downto 7) = "0000010" or
                  instrucao(13 downto 8) = "000010" or
                  instrucao(13 downto 8) = "001110" or
                  instrucao(13 downto 8) = "111100" or
                  instrucao(13 downto 8) = "111110"
                  else "01" when
                  instrucao(13 downto 8) = "001000" or
                  instrucao(13 downto 7) = "0000001" or
                  instrucao(13 downto 8) = "110000"
                  else (others=>'0');

    br_hab_escr <= estado when
                    instrucao(13 downto 8) = "000111" or
                    instrucao(13 downto 7) = "0000011" or
                    instrucao(13 downto 7) = "0000010" or
                    instrucao(13 downto 8) = "000010" or
                    instrucao(13 downto 8) = "001110" or
                    instrucao(13 downto 8) = "111100" or
                    instrucao(13 downto 8) = "111110" or
                    instrucao(13 downto 8) = "001000" or
                    instrucao(13 downto 7) = "0000001" or
                    instrucao(13 downto 8) = "110000"
                    else '0';

    reg_escr <= "0000000" when
                (instrucao(13 downto 8) = "000111" and instrucao(7) = '0') or
                instrucao(13 downto 7) = "0000010" or
                (instrucao(13 downto 8) = "001000" and instrucao(7) = '0') or
                (instrucao(13 downto 8) = "000010" and instrucao(7) = '0') or
                (instrucao(13 downto 8) = "001110" and instrucao(7) = '0') or
                instrucao(13 downto 8) = "111110" or
                instrucao(13 downto 8) = "110000" or
                instrucao(13 downto 8) = "111100"
                else instrucao(6 downto 0) when
                (instrucao(13 downto 8) = "000111" and instrucao(7) = '1') or
                instrucao(13 downto 7) = "0000011" or
                (instrucao(13 downto 8) = "001000" and instrucao(7) = '1') or
                (instrucao(13 downto 8) = "000010" and instrucao(7) = '1') or
                (instrucao(13 downto 8) = "001110" and instrucao(7) = '1') or
                instrucao(13 downto 7) = "0000001"
                else (others=>'0');

end architecture;
