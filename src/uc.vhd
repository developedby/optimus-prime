library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc is
  port(
     clk, rst: in std_logic;
     rom_saida: in unsigned(13 downto 0);
     pc_hab_escr: out std_logic;
     orig_pc: out std_logic;
     ula_op: out unsigned(1 downto 0);
     reg_le_1, reg_le_2, reg_escr: out unsigned(6 downto 0);
     orig_ula_1: out unsigned(1 downto 0);
     orig_ula_2: out unsigned(1 downto 0);
     br_hab_escr: out std_logic;
     hab_escr_z, hab_escr_c: out std_logic;
     pula_em: out std_logic;
     pula_instr_ula: in std_logic
  );
end entity;

architecture arq_uc of uc is
signal estado: std_logic;
signal instrucao: unsigned(13 downto 0);
signal pula_instr: std_logic;

component ff_t is
  port(
    clk, rst: in std_logic;
    saida: out std_logic
  );
end component;

component reg1bit is
  port(
    clk, rst, hab_escr: in std_logic;
	entrada: in std_logic;
	saida: out std_logic
  );
end component;

begin
  maq_estado: ff_t port map (
        clk => clk,
        rst => rst,
        saida => estado
  );

  reg_pula_instrucao: monoestavel port map (
        clk => clk,
        rst => rst,
        entrada => pula_instr_ula,
        saida => pula_instr
  );

  instrucao <= "0000000000000000" when pula_instr = '1' else
               rom_saida when estado = '0' else
               instrucao;

  pc_hab_escr <= estado;

  --GOTO ou incrementa PC

    --BRA
    --when instrucao(13 downto 10) = "1100"

  orig_pc <= '0' when --vem da ula
             instrucao(13 downto 11) = "101" or --GOTO
             instrucao(13 downto 10) = "1100" or --BRA
             instrucao = "00000000001011" --BRW
             else '1'; --incrementa 1 no pc

  ula_op <= "00" when --soma
            instrucao(13 downto 8) = "000111" or
            instrucao(13 downto 8) = "001000" or
            instrucao(13 downto 7) = "0000001" or
            instrucao(13 downto 8) = "111110" or
            instrucao(13 downto 11) = "101" or
            instrucao(13 downto 10) = "1100" or
            instrucao = "00000000001011"
            else "01" when --sub
            instrucao(13 downto 7) = "0000011" or
            instrucao(13 downto 7) = "0000010" or
            instrucao(13 downto 8) = "000010" or
            instrucao(13 downto 8) = "111100"
            else "10" when --testa bit
            instrucao(13 downto 11) = "010" or
            instrucao(13 downto 11) = "011"
            else "11" when --swap
            instrucao(13 downto 8) = "001110"
            else (others=>'0');

  reg_le_1 <= "0000010" when
               instrucao(13 downto 7) = "0000010" or
               instrucao(13 downto 7) = "0000001"
               else instrucao(6 downto 0) when
               instrucao(13 downto 8) = "000111" or
               instrucao(13 downto 7) = "0000011" or
               instrucao(13 downto 8) = "001000" or
               instrucao(13 downto 8) = "000010" or
               instrucao(13 downto 8) = "001110"
               else (others=>'0');

    reg_le_2 <= "0000010" when
                instrucao(13 downto 8) = "000111" or
                instrucao(13 downto 7) = "0000010" or
                instrucao(13 downto 8) = "000010" or
                instrucao(13 downto 8) = "111110" or
                instrucao(13 downto 8) = "111100" or
                instrucao = "00000000001011"
                else instrucao(6 downto 0) when
                instrucao(13 downto 7) = "0000011" or
                instrucao(13 downto 8) = "001110"
                else (others=>'0');

  orig_ula_1 <= "00" when --reg
                instrucao(13 downto 8) = "000111" or
                instrucao(13 downto 7) = "0000011" or
                instrucao(13 downto 7) = "0000010" or
                instrucao(13 downto 8) = "001000" or
                instrucao(13 downto 7) = "0000001" or
                instrucao(13 downto 8) = "000010" or
                instrucao(13 downto 8) = "001110"
                else "01" when --constante da instr literal
                instrucao(13 downto 8) = "111110" or
                instrucao(13 downto 8) = "110000" or
                instrucao(13 downto 8) = "111100"
                else "10" when --vem do pc
                instrucao(13 downto 10) = "1100" or
                instrucao = "00000000001011"
                else "11" when --constante GOTO
                instrucao(13 downto 11) = "101"
                else (others=>'0');

    orig_ula_2 <= "00" when --reg
                  instrucao(13 downto 8) = "000111" or
                  instrucao(13 downto 7) = "0000011" or
                  instrucao(13 downto 7) = "0000010" or
                  instrucao(13 downto 8) = "000010" or
                  instrucao(13 downto 8) = "001110" or
                  instrucao(13 downto 8) = "111100" or
                  instrucao(13 downto 8) = "111110" or
                  instrucao = "00000000001011"
                  else "01" when --constante 0
                  instrucao(13 downto 8) = "001000" or
                  instrucao(13 downto 7) = "0000001" or
                  instrucao(13 downto 8) = "110000" or
                  instrucao(13 downto 11) = "101"
                  else "10" when --constante BRA
                  instrucao(13 downto 10) = "1100"
                  else "11" when --testa bit
                  instrucao(13 downto 11) = "010" or
                  instrucao(13 downto 10) = "011"
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

    hab_escr_z <= '1' when
                instrucao(13 downto 8) = "000111" or --addwf
                instrucao(13 downto 7) = "0000011" or --clrf
                instrucao(13 downto 7) = "0000010" or --clrw
                instrucao(13 downto 8) = "001000" or --movf
                instrucao(13 downto 8) = "000010" or --subwfb
                instrucao(13 downto 8) = "111110" or --addlw
                instrucao(13 downto 8) = "111100" or --sublw
                instrucao(13 downto 3) = "00000000010" or --moviw
                instrucao(13 downto 3) = "00000000011" --movwi
            else (others=>'0');

    hab_escr_c <= '1' when
                instrucao(13 downto 8) = "000111" or --addwf
                instrucao(13 downto 8) = "000010" or --subwfb
                instrucao(13 downto 8) = "111110" or --addlw
                instrucao(13 downto 8) = "111100" or --sublw
            else (others=>'0');

    pula_em <= instrucao(11);
end architecture;
