library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Unidade de controle
-- Decodifica instruções e seta sinais de controle

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
     pula_instr_ula: in std_logic;
	 hab_escr_ram: out std_logic;
	 orig_br: out std_logic
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

component monoestavel is
  port(
    clk, rst: in std_logic;
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

  -- Sinal intermediario que recebe a intrucao da rom em momentos adequados
  instrucao <= "00000000000000" when pula_instr = '1' else
               rom_saida when estado = '0' else
               instrucao;

  -- Habilita escrita do PC quando estado = '1'
  pc_hab_escr <= estado;

  -- Seleciona se soma 1 ou pula
  orig_pc <= '0' when --vem da ula
             instrucao(13 downto 11) = "101" or --GOTO
             instrucao(13 downto 9) = "11001" or --BRA
             instrucao = "00000000001011" --BRW
             else '1'; --incrementa 1 no pc

  -- Seleciona operação que a ula vai fazer
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

  -- Escolhe registrador para ler no banco de registradores
  reg_le_1 <= "0000010" when -- W
               instrucao(13 downto 7) = "0000010" or
               instrucao(13 downto 7) = "0000001"
               else instrucao(6 downto 0) when -- f
               instrucao(13 downto 8) = "000111" or
               instrucao(13 downto 7) = "0000011" or
               instrucao(13 downto 8) = "001000" or
               instrucao(13 downto 8) = "000010" or
               instrucao(13 downto 8) = "001110" or
               instrucao(13 downto 11) = "010" or
               instrucao(13 downto 11) = "011"
               else "1111" & instrucao(2 downto 0) when -- FSRn
			   instrucao(13 downto 3) = "00000000010" or -- MOVIW
			   instrucao(13 downto 3) = "00000000011"    -- MOVWI
			   else (others=>'0');

  reg_le_2 <= "0000010" when -- W
                instrucao(13 downto 8) = "000111" or
                instrucao(13 downto 7) = "0000010" or
                instrucao(13 downto 8) = "000010" or
                instrucao(13 downto 8) = "111110" or
                instrucao(13 downto 8) = "111100" or
				instrucao(13 downto 3) = "00000000010" or -- MOVIW
			    instrucao(13 downto 3) = "00000000011" or -- MOVWI
                instrucao = "00000000001011"
                else instrucao(6 downto 0) when -- f
                instrucao(13 downto 7) = "0000011" or
                instrucao(13 downto 8) = "001110"
                else (others=>'0');

  -- Seleciona da onde vem o dado para a ula
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
                instrucao(13 downto 9) = "11001" or
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
                  instrucao(13 downto 9) = "11001"
                  else "11" when --testa bit
                  instrucao(13 downto 11) = "010" or
                  instrucao(13 downto 11) = "011"
                  else (others=>'0');

	-- Habilita escrita no banco de registradores quando estado = '1'
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
                    instrucao(13 downto 8) = "110000" or
                    instrucao(13 downto 3) = "00000000010"
                    else '0';

	-- Seleeciona em qual registrador escrever o dado que esta chegando
    reg_escr <= "0000010" when -- W
                (instrucao(13 downto 8) = "000111" and instrucao(7) = '0') or
                instrucao(13 downto 7) = "0000010" or
                (instrucao(13 downto 8) = "001000" and instrucao(7) = '0') or
                (instrucao(13 downto 8) = "000010" and instrucao(7) = '0') or
                (instrucao(13 downto 8) = "001110" and instrucao(7) = '0') or
                instrucao(13 downto 8) = "111110" or
                instrucao(13 downto 8) = "110000" or
                instrucao(13 downto 8) = "111100" or
                instrucao(13 downto 3) = "00000000010"
                else instrucao(6 downto 0) when -- f
                (instrucao(13 downto 8) = "000111" and instrucao(7) = '1') or
                instrucao(13 downto 7) = "0000011" or
                (instrucao(13 downto 8) = "001000" and instrucao(7) = '1') or
                (instrucao(13 downto 8) = "000010" and instrucao(7) = '1') or
                (instrucao(13 downto 8) = "001110" and instrucao(7) = '1') or
                instrucao(13 downto 7) = "0000001"
                else (others=>'0');

	-- Habilita escrita da flag Z(zero) nas operações que o modificam
    hab_escr_z <= estado when
                instrucao(13 downto 8) = "000111" or --addwf
                instrucao(13 downto 7) = "0000011" or --clrf
                instrucao(13 downto 7) = "0000010" or --clrw
                instrucao(13 downto 8) = "001000" or --movf
                instrucao(13 downto 8) = "000010" or --subwfb
                instrucao(13 downto 8) = "111110" or --addlw
                instrucao(13 downto 8) = "111100" --sublw
                --movs da ram nao ativam Z ja que nao passam ula
            else '0';

	-- Habilita escrita da flag C(carry) nas operações que o modificam
    hab_escr_c <= estado when
                instrucao(13 downto 8) = "000111" or --addwf
                instrucao(13 downto 8) = "000010" or --subwfb
                instrucao(13 downto 8) = "111110" or --addlw
                instrucao(13 downto 8) = "111100" --sublw
            else '0';

	-- Para as instruções que checam bit, escolhe se pula em clear(0) ou set(1)
    pula_em <= instrucao(11);

	-- Escreve na ram ou não
	hab_escr_ram <= '1' when instrucao(13 downto 3) = "00000000011" --movwi
					else '0'; --outras instrucoes

	-- Seleciona da onde vem a entrada de dados do banco de registradores
	orig_br <= '1' when instrucao(13 downto 3) = "00000000010" --moviw
				else '0'; --outras instrucoes

end architecture;
