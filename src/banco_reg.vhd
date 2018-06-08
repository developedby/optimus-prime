library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_reg is
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
end entity;

architecture arq_banco_reg of banco_reg is
  component reg16bit is
    port(
      clk, rst, hab_escr: in std_logic;
	  entrada: in unsigned(15 downto 0);
	  saida: out unsigned(15 downto 0)
    );
  end component;
  type std_logic_array_128bit is array(127 downto 0) of std_logic;
  signal hab_reg_escr: std_logic_array_128bit;
  type unsigned_array_128x16 is array(127 downto 0) of unsigned(15 downto 0);
  signal saida_reg: unsigned_array_128x16;

  signal entr_dados_z, entr_dados_c: unsigned(15 downto 0);

begin
  registradores:
  for i in 0 to 127 generate
      regZero:
        if i = 0 generate
          regZ: reg16bit port map (
    	    clk => clk,
    		rst => rst,
    		hab_escr => hab_reg_escr(i),
    		entrada => entr_dados_z,
    		saida => saida_reg(i)
    	  );
      end generate regZero;
      regCarry:
        if i = 1 generate
          regC: reg16bit port map (
    	    clk => clk,
    		rst => rst,
    		hab_escr => hab_reg_escr(i),
    		entrada => entr_dados_c,
    		saida => saida_reg(i)
    	  );
      end generate regCarry;
      outros_regs:
        if i > 1 generate
	      regX: reg16bit port map (
	        clk => clk,
		    rst => rst,
		    hab_escr => hab_reg_escr(i),
		    entrada => entr_dados,
		    saida => saida_reg(i)
	  );
      end generate outros_regs;
  end generate;

  entr_dados_z <= entr_dados when sel_reg_escr = "0000000" else entr_z;
  entr_dados_c <= entr_dados when sel_reg_escr = "0000000" else entr_c;

  saida_dados1 <= saida_reg(0) when sel_reg_le1 = "0000000" else
                    saida_reg(1) when sel_reg_le1 = "0000001" else
                    saida_reg(2) when sel_reg_le1 = "0000010" else
                    saida_reg(3) when sel_reg_le1 = "0000011" else
                    saida_reg(4) when sel_reg_le1 = "0000100" else
                    saida_reg(5) when sel_reg_le1 = "0000101" else
                    saida_reg(6) when sel_reg_le1 = "0000110" else
                    saida_reg(7) when sel_reg_le1 = "0000111" else
                    saida_reg(8) when sel_reg_le1 = "0001000" else
                    saida_reg(9) when sel_reg_le1 = "0001001" else
                    saida_reg(10) when sel_reg_le1 = "0001010" else
                    saida_reg(11) when sel_reg_le1 = "0001011" else
                    saida_reg(12) when sel_reg_le1 = "0001100" else
                    saida_reg(13) when sel_reg_le1 = "0001101" else
                    saida_reg(14) when sel_reg_le1 = "0001110" else
                    saida_reg(15) when sel_reg_le1 = "0001111" else
                    saida_reg(16) when sel_reg_le1 = "0010000" else
                    saida_reg(17) when sel_reg_le1 = "0010001" else
                    saida_reg(18) when sel_reg_le1 = "0010010" else
                    saida_reg(19) when sel_reg_le1 = "0010011" else
                    saida_reg(20) when sel_reg_le1 = "0010100" else
                    saida_reg(21) when sel_reg_le1 = "0010101" else
                    saida_reg(22) when sel_reg_le1 = "0010110" else
                    saida_reg(23) when sel_reg_le1 = "0010111" else
                    saida_reg(24) when sel_reg_le1 = "0011000" else
                    saida_reg(25) when sel_reg_le1 = "0011001" else
                    saida_reg(26) when sel_reg_le1 = "0011010" else
                    saida_reg(27) when sel_reg_le1 = "0011011" else
                    saida_reg(28) when sel_reg_le1 = "0011100" else
                    saida_reg(29) when sel_reg_le1 = "0011101" else
                    saida_reg(30) when sel_reg_le1 = "0011110" else
                    saida_reg(31) when sel_reg_le1 = "0011111" else
                    saida_reg(32) when sel_reg_le1 = "0100000" else
                    saida_reg(33) when sel_reg_le1 = "0100001" else
                    saida_reg(34) when sel_reg_le1 = "0100010" else
                    saida_reg(35) when sel_reg_le1 = "0100011" else
                    saida_reg(36) when sel_reg_le1 = "0100100" else
                    saida_reg(37) when sel_reg_le1 = "0100101" else
                    saida_reg(38) when sel_reg_le1 = "0100110" else
                    saida_reg(39) when sel_reg_le1 = "0100111" else
                    saida_reg(40) when sel_reg_le1 = "0101000" else
                    saida_reg(41) when sel_reg_le1 = "0101001" else
                    saida_reg(42) when sel_reg_le1 = "0101010" else
                    saida_reg(43) when sel_reg_le1 = "0101011" else
                    saida_reg(44) when sel_reg_le1 = "0101100" else
                    saida_reg(45) when sel_reg_le1 = "0101101" else
                    saida_reg(46) when sel_reg_le1 = "0101110" else
                    saida_reg(47) when sel_reg_le1 = "0101111" else
                    saida_reg(48) when sel_reg_le1 = "0110000" else
                    saida_reg(49) when sel_reg_le1 = "0110001" else
                    saida_reg(50) when sel_reg_le1 = "0110010" else
                    saida_reg(51) when sel_reg_le1 = "0110011" else
                    saida_reg(52) when sel_reg_le1 = "0110100" else
                    saida_reg(53) when sel_reg_le1 = "0110101" else
                    saida_reg(54) when sel_reg_le1 = "0110110" else
                    saida_reg(55) when sel_reg_le1 = "0110111" else
                    saida_reg(56) when sel_reg_le1 = "0111000" else
                    saida_reg(57) when sel_reg_le1 = "0111001" else
                    saida_reg(58) when sel_reg_le1 = "0111010" else
                    saida_reg(59) when sel_reg_le1 = "0111011" else
                    saida_reg(60) when sel_reg_le1 = "0111100" else
                    saida_reg(61) when sel_reg_le1 = "0111101" else
                    saida_reg(62) when sel_reg_le1 = "0111110" else
                    saida_reg(63) when sel_reg_le1 = "0111111" else
                    saida_reg(64) when sel_reg_le1 = "1000000" else
                    saida_reg(65) when sel_reg_le1 = "1000001" else
                    saida_reg(66) when sel_reg_le1 = "1000010" else
                    saida_reg(67) when sel_reg_le1 = "1000011" else
                    saida_reg(68) when sel_reg_le1 = "1000100" else
                    saida_reg(69) when sel_reg_le1 = "1000101" else
                    saida_reg(70) when sel_reg_le1 = "1000110" else
                    saida_reg(71) when sel_reg_le1 = "1000111" else
                    saida_reg(72) when sel_reg_le1 = "1001000" else
                    saida_reg(73) when sel_reg_le1 = "1001001" else
                    saida_reg(74) when sel_reg_le1 = "1001010" else
                    saida_reg(75) when sel_reg_le1 = "1001011" else
                    saida_reg(76) when sel_reg_le1 = "1001100" else
                    saida_reg(77) when sel_reg_le1 = "1001101" else
                    saida_reg(78) when sel_reg_le1 = "1001110" else
                    saida_reg(79) when sel_reg_le1 = "1001111" else
                    saida_reg(80) when sel_reg_le1 = "1010000" else
                    saida_reg(81) when sel_reg_le1 = "1010001" else
                    saida_reg(82) when sel_reg_le1 = "1010010" else
                    saida_reg(83) when sel_reg_le1 = "1010011" else
                    saida_reg(84) when sel_reg_le1 = "1010100" else
                    saida_reg(85) when sel_reg_le1 = "1010101" else
                    saida_reg(86) when sel_reg_le1 = "1010110" else
                    saida_reg(87) when sel_reg_le1 = "1010111" else
                    saida_reg(88) when sel_reg_le1 = "1011000" else
                    saida_reg(89) when sel_reg_le1 = "1011001" else
                    saida_reg(90) when sel_reg_le1 = "1011010" else
                    saida_reg(91) when sel_reg_le1 = "1011011" else
                    saida_reg(92) when sel_reg_le1 = "1011100" else
                    saida_reg(93) when sel_reg_le1 = "1011101" else
                    saida_reg(94) when sel_reg_le1 = "1011110" else
                    saida_reg(95) when sel_reg_le1 = "1011111" else
                    saida_reg(96) when sel_reg_le1 = "1100000" else
                    saida_reg(97) when sel_reg_le1 = "1100001" else
                    saida_reg(98) when sel_reg_le1 = "1100010" else
                    saida_reg(99) when sel_reg_le1 = "1100011" else
                    saida_reg(100) when sel_reg_le1 = "1100100" else
                    saida_reg(101) when sel_reg_le1 = "1100101" else
                    saida_reg(102) when sel_reg_le1 = "1100110" else
                    saida_reg(103) when sel_reg_le1 = "1100111" else
                    saida_reg(104) when sel_reg_le1 = "1101000" else
                    saida_reg(105) when sel_reg_le1 = "1101001" else
                    saida_reg(106) when sel_reg_le1 = "1101010" else
                    saida_reg(107) when sel_reg_le1 = "1101011" else
                    saida_reg(108) when sel_reg_le1 = "1101100" else
                    saida_reg(109) when sel_reg_le1 = "1101101" else
                    saida_reg(110) when sel_reg_le1 = "1101110" else
                    saida_reg(111) when sel_reg_le1 = "1101111" else
                    saida_reg(112) when sel_reg_le1 = "1110000" else
                    saida_reg(113) when sel_reg_le1 = "1110001" else
                    saida_reg(114) when sel_reg_le1 = "1110010" else
                    saida_reg(115) when sel_reg_le1 = "1110011" else
                    saida_reg(116) when sel_reg_le1 = "1110100" else
                    saida_reg(117) when sel_reg_le1 = "1110101" else
                    saida_reg(118) when sel_reg_le1 = "1110110" else
                    saida_reg(119) when sel_reg_le1 = "1110111" else
                    saida_reg(120) when sel_reg_le1 = "1111000" else
                    saida_reg(121) when sel_reg_le1 = "1111001" else
                    saida_reg(122) when sel_reg_le1 = "1111010" else
                    saida_reg(123) when sel_reg_le1 = "1111011" else
                    saida_reg(124) when sel_reg_le1 = "1111100" else
                    saida_reg(125) when sel_reg_le1 = "1111101" else
                    saida_reg(126) when sel_reg_le1 = "1111110" else
                    saida_reg(127) when sel_reg_le1 = "1111111" else
			      (others=>'0');
  saida_dados2 <= saida_reg(0) when sel_reg_le2 = "0000000" else
                  saida_reg(1) when sel_reg_le2 = "0000001" else
                  saida_reg(2) when sel_reg_le2 = "0000010" else
                  saida_reg(3) when sel_reg_le2 = "0000011" else
                  saida_reg(4) when sel_reg_le2 = "0000100" else
                  saida_reg(5) when sel_reg_le2 = "0000101" else
                  saida_reg(6) when sel_reg_le2 = "0000110" else
                  saida_reg(7) when sel_reg_le2 = "0000111" else
                  saida_reg(8) when sel_reg_le2 = "0001000" else
                  saida_reg(9) when sel_reg_le2 = "0001001" else
                  saida_reg(10) when sel_reg_le2 = "0001010" else
                  saida_reg(11) when sel_reg_le2 = "0001011" else
                  saida_reg(12) when sel_reg_le2 = "0001100" else
                  saida_reg(13) when sel_reg_le2 = "0001101" else
                  saida_reg(14) when sel_reg_le2 = "0001110" else
                  saida_reg(15) when sel_reg_le2 = "0001111" else
                  saida_reg(16) when sel_reg_le2 = "0010000" else
                  saida_reg(17) when sel_reg_le2 = "0010001" else
                  saida_reg(18) when sel_reg_le2 = "0010010" else
                  saida_reg(19) when sel_reg_le2 = "0010011" else
                  saida_reg(20) when sel_reg_le2 = "0010100" else
                  saida_reg(21) when sel_reg_le2 = "0010101" else
                  saida_reg(22) when sel_reg_le2 = "0010110" else
                  saida_reg(23) when sel_reg_le2 = "0010111" else
                  saida_reg(24) when sel_reg_le2 = "0011000" else
                  saida_reg(25) when sel_reg_le2 = "0011001" else
                  saida_reg(26) when sel_reg_le2 = "0011010" else
                  saida_reg(27) when sel_reg_le2 = "0011011" else
                  saida_reg(28) when sel_reg_le2 = "0011100" else
                  saida_reg(29) when sel_reg_le2 = "0011101" else
                  saida_reg(30) when sel_reg_le2 = "0011110" else
                  saida_reg(31) when sel_reg_le2 = "0011111" else
                  saida_reg(32) when sel_reg_le2 = "0100000" else
                  saida_reg(33) when sel_reg_le2 = "0100001" else
                  saida_reg(34) when sel_reg_le2 = "0100010" else
                  saida_reg(35) when sel_reg_le2 = "0100011" else
                  saida_reg(36) when sel_reg_le2 = "0100100" else
                  saida_reg(37) when sel_reg_le2 = "0100101" else
                  saida_reg(38) when sel_reg_le2 = "0100110" else
                  saida_reg(39) when sel_reg_le2 = "0100111" else
                  saida_reg(40) when sel_reg_le2 = "0101000" else
                  saida_reg(41) when sel_reg_le2 = "0101001" else
                  saida_reg(42) when sel_reg_le2 = "0101010" else
                  saida_reg(43) when sel_reg_le2 = "0101011" else
                  saida_reg(44) when sel_reg_le2 = "0101100" else
                  saida_reg(45) when sel_reg_le2 = "0101101" else
                  saida_reg(46) when sel_reg_le2 = "0101110" else
                  saida_reg(47) when sel_reg_le2 = "0101111" else
                  saida_reg(48) when sel_reg_le2 = "0110000" else
                  saida_reg(49) when sel_reg_le2 = "0110001" else
                  saida_reg(50) when sel_reg_le2 = "0110010" else
                  saida_reg(51) when sel_reg_le2 = "0110011" else
                  saida_reg(52) when sel_reg_le2 = "0110100" else
                  saida_reg(53) when sel_reg_le2 = "0110101" else
                  saida_reg(54) when sel_reg_le2 = "0110110" else
                  saida_reg(55) when sel_reg_le2 = "0110111" else
                  saida_reg(56) when sel_reg_le2 = "0111000" else
                  saida_reg(57) when sel_reg_le2 = "0111001" else
                  saida_reg(58) when sel_reg_le2 = "0111010" else
                  saida_reg(59) when sel_reg_le2 = "0111011" else
                  saida_reg(60) when sel_reg_le2 = "0111100" else
                  saida_reg(61) when sel_reg_le2 = "0111101" else
                  saida_reg(62) when sel_reg_le2 = "0111110" else
                  saida_reg(63) when sel_reg_le2 = "0111111" else
                  saida_reg(64) when sel_reg_le2 = "1000000" else
                  saida_reg(65) when sel_reg_le2 = "1000001" else
                  saida_reg(66) when sel_reg_le2 = "1000010" else
                  saida_reg(67) when sel_reg_le2 = "1000011" else
                  saida_reg(68) when sel_reg_le2 = "1000100" else
                  saida_reg(69) when sel_reg_le2 = "1000101" else
                  saida_reg(70) when sel_reg_le2 = "1000110" else
                  saida_reg(71) when sel_reg_le2 = "1000111" else
                  saida_reg(72) when sel_reg_le2 = "1001000" else
                  saida_reg(73) when sel_reg_le2 = "1001001" else
                  saida_reg(74) when sel_reg_le2 = "1001010" else
                  saida_reg(75) when sel_reg_le2 = "1001011" else
                  saida_reg(76) when sel_reg_le2 = "1001100" else
                  saida_reg(77) when sel_reg_le2 = "1001101" else
                  saida_reg(78) when sel_reg_le2 = "1001110" else
                  saida_reg(79) when sel_reg_le2 = "1001111" else
                  saida_reg(80) when sel_reg_le2 = "1010000" else
                  saida_reg(81) when sel_reg_le2 = "1010001" else
                  saida_reg(82) when sel_reg_le2 = "1010010" else
                  saida_reg(83) when sel_reg_le2 = "1010011" else
                  saida_reg(84) when sel_reg_le2 = "1010100" else
                  saida_reg(85) when sel_reg_le2 = "1010101" else
                  saida_reg(86) when sel_reg_le2 = "1010110" else
                  saida_reg(87) when sel_reg_le2 = "1010111" else
                  saida_reg(88) when sel_reg_le2 = "1011000" else
                  saida_reg(89) when sel_reg_le2 = "1011001" else
                  saida_reg(90) when sel_reg_le2 = "1011010" else
                  saida_reg(91) when sel_reg_le2 = "1011011" else
                  saida_reg(92) when sel_reg_le2 = "1011100" else
                  saida_reg(93) when sel_reg_le2 = "1011101" else
                  saida_reg(94) when sel_reg_le2 = "1011110" else
                  saida_reg(95) when sel_reg_le2 = "1011111" else
                  saida_reg(96) when sel_reg_le2 = "1100000" else
                  saida_reg(97) when sel_reg_le2 = "1100001" else
                  saida_reg(98) when sel_reg_le2 = "1100010" else
                  saida_reg(99) when sel_reg_le2 = "1100011" else
                  saida_reg(100) when sel_reg_le2 = "1100100" else
                  saida_reg(101) when sel_reg_le2 = "1100101" else
                  saida_reg(102) when sel_reg_le2 = "1100110" else
                  saida_reg(103) when sel_reg_le2 = "1100111" else
                  saida_reg(104) when sel_reg_le2 = "1101000" else
                  saida_reg(105) when sel_reg_le2 = "1101001" else
                  saida_reg(106) when sel_reg_le2 = "1101010" else
                  saida_reg(107) when sel_reg_le2 = "1101011" else
                  saida_reg(108) when sel_reg_le2 = "1101100" else
                  saida_reg(109) when sel_reg_le2 = "1101101" else
                  saida_reg(110) when sel_reg_le2 = "1101110" else
                  saida_reg(111) when sel_reg_le2 = "1101111" else
                  saida_reg(112) when sel_reg_le2 = "1110000" else
                  saida_reg(113) when sel_reg_le2 = "1110001" else
                  saida_reg(114) when sel_reg_le2 = "1110010" else
                  saida_reg(115) when sel_reg_le2 = "1110011" else
                  saida_reg(116) when sel_reg_le2 = "1110100" else
                  saida_reg(117) when sel_reg_le2 = "1110101" else
                  saida_reg(118) when sel_reg_le2 = "1110110" else
                  saida_reg(119) when sel_reg_le2 = "1110111" else
                  saida_reg(120) when sel_reg_le2 = "1111000" else
                  saida_reg(121) when sel_reg_le2 = "1111001" else
                  saida_reg(122) when sel_reg_le2 = "1111010" else
                  saida_reg(123) when sel_reg_le2 = "1111011" else
                  saida_reg(124) when sel_reg_le2 = "1111100" else
                  saida_reg(125) when sel_reg_le2 = "1111101" else
                  saida_reg(126) when sel_reg_le2 = "1111110" else
                  saida_reg(127) when sel_reg_le2 = "1111111" else
			      (others=>'0');

hab_reg_escr(0) <= hab_escr when sel_reg_escr = "0000000" else hab_escr_z;
hab_reg_escr(1) <= hab_escr when sel_reg_escr = "0000001" else hab_escr_c;
hab_reg_escr(2) <= hab_escr when sel_reg_escr = "0000010" else '0';
hab_reg_escr(3) <= hab_escr when sel_reg_escr = "0000011" else '0';
hab_reg_escr(4) <= hab_escr when sel_reg_escr = "0000100" else '0';
hab_reg_escr(5) <= hab_escr when sel_reg_escr = "0000101" else '0';
hab_reg_escr(6) <= hab_escr when sel_reg_escr = "0000110" else '0';
hab_reg_escr(7) <= hab_escr when sel_reg_escr = "0000111" else '0';
hab_reg_escr(8) <= hab_escr when sel_reg_escr = "0001000" else '0';
hab_reg_escr(9) <= hab_escr when sel_reg_escr = "0001001" else '0';
hab_reg_escr(10) <= hab_escr when sel_reg_escr = "0001010" else '0';
hab_reg_escr(11) <= hab_escr when sel_reg_escr = "0001011" else '0';
hab_reg_escr(12) <= hab_escr when sel_reg_escr = "0001100" else '0';
hab_reg_escr(13) <= hab_escr when sel_reg_escr = "0001101" else '0';
hab_reg_escr(14) <= hab_escr when sel_reg_escr = "0001110" else '0';
hab_reg_escr(15) <= hab_escr when sel_reg_escr = "0001111" else '0';
hab_reg_escr(16) <= hab_escr when sel_reg_escr = "0010000" else '0';
hab_reg_escr(17) <= hab_escr when sel_reg_escr = "0010001" else '0';
hab_reg_escr(18) <= hab_escr when sel_reg_escr = "0010010" else '0';
hab_reg_escr(19) <= hab_escr when sel_reg_escr = "0010011" else '0';
hab_reg_escr(20) <= hab_escr when sel_reg_escr = "0010100" else '0';
hab_reg_escr(21) <= hab_escr when sel_reg_escr = "0010101" else '0';
hab_reg_escr(22) <= hab_escr when sel_reg_escr = "0010110" else '0';
hab_reg_escr(23) <= hab_escr when sel_reg_escr = "0010111" else '0';
hab_reg_escr(24) <= hab_escr when sel_reg_escr = "0011000" else '0';
hab_reg_escr(25) <= hab_escr when sel_reg_escr = "0011001" else '0';
hab_reg_escr(26) <= hab_escr when sel_reg_escr = "0011010" else '0';
hab_reg_escr(27) <= hab_escr when sel_reg_escr = "0011011" else '0';
hab_reg_escr(28) <= hab_escr when sel_reg_escr = "0011100" else '0';
hab_reg_escr(29) <= hab_escr when sel_reg_escr = "0011101" else '0';
hab_reg_escr(30) <= hab_escr when sel_reg_escr = "0011110" else '0';
hab_reg_escr(31) <= hab_escr when sel_reg_escr = "0011111" else '0';
hab_reg_escr(32) <= hab_escr when sel_reg_escr = "0100000" else '0';
hab_reg_escr(33) <= hab_escr when sel_reg_escr = "0100001" else '0';
hab_reg_escr(34) <= hab_escr when sel_reg_escr = "0100010" else '0';
hab_reg_escr(35) <= hab_escr when sel_reg_escr = "0100011" else '0';
hab_reg_escr(36) <= hab_escr when sel_reg_escr = "0100100" else '0';
hab_reg_escr(37) <= hab_escr when sel_reg_escr = "0100101" else '0';
hab_reg_escr(38) <= hab_escr when sel_reg_escr = "0100110" else '0';
hab_reg_escr(39) <= hab_escr when sel_reg_escr = "0100111" else '0';
hab_reg_escr(40) <= hab_escr when sel_reg_escr = "0101000" else '0';
hab_reg_escr(41) <= hab_escr when sel_reg_escr = "0101001" else '0';
hab_reg_escr(42) <= hab_escr when sel_reg_escr = "0101010" else '0';
hab_reg_escr(43) <= hab_escr when sel_reg_escr = "0101011" else '0';
hab_reg_escr(44) <= hab_escr when sel_reg_escr = "0101100" else '0';
hab_reg_escr(45) <= hab_escr when sel_reg_escr = "0101101" else '0';
hab_reg_escr(46) <= hab_escr when sel_reg_escr = "0101110" else '0';
hab_reg_escr(47) <= hab_escr when sel_reg_escr = "0101111" else '0';
hab_reg_escr(48) <= hab_escr when sel_reg_escr = "0110000" else '0';
hab_reg_escr(49) <= hab_escr when sel_reg_escr = "0110001" else '0';
hab_reg_escr(50) <= hab_escr when sel_reg_escr = "0110010" else '0';
hab_reg_escr(51) <= hab_escr when sel_reg_escr = "0110011" else '0';
hab_reg_escr(52) <= hab_escr when sel_reg_escr = "0110100" else '0';
hab_reg_escr(53) <= hab_escr when sel_reg_escr = "0110101" else '0';
hab_reg_escr(54) <= hab_escr when sel_reg_escr = "0110110" else '0';
hab_reg_escr(55) <= hab_escr when sel_reg_escr = "0110111" else '0';
hab_reg_escr(56) <= hab_escr when sel_reg_escr = "0111000" else '0';
hab_reg_escr(57) <= hab_escr when sel_reg_escr = "0111001" else '0';
hab_reg_escr(58) <= hab_escr when sel_reg_escr = "0111010" else '0';
hab_reg_escr(59) <= hab_escr when sel_reg_escr = "0111011" else '0';
hab_reg_escr(60) <= hab_escr when sel_reg_escr = "0111100" else '0';
hab_reg_escr(61) <= hab_escr when sel_reg_escr = "0111101" else '0';
hab_reg_escr(62) <= hab_escr when sel_reg_escr = "0111110" else '0';
hab_reg_escr(63) <= hab_escr when sel_reg_escr = "0111111" else '0';
hab_reg_escr(64) <= hab_escr when sel_reg_escr = "1000000" else '0';
hab_reg_escr(65) <= hab_escr when sel_reg_escr = "1000001" else '0';
hab_reg_escr(66) <= hab_escr when sel_reg_escr = "1000010" else '0';
hab_reg_escr(67) <= hab_escr when sel_reg_escr = "1000011" else '0';
hab_reg_escr(68) <= hab_escr when sel_reg_escr = "1000100" else '0';
hab_reg_escr(69) <= hab_escr when sel_reg_escr = "1000101" else '0';
hab_reg_escr(70) <= hab_escr when sel_reg_escr = "1000110" else '0';
hab_reg_escr(71) <= hab_escr when sel_reg_escr = "1000111" else '0';
hab_reg_escr(72) <= hab_escr when sel_reg_escr = "1001000" else '0';
hab_reg_escr(73) <= hab_escr when sel_reg_escr = "1001001" else '0';
hab_reg_escr(74) <= hab_escr when sel_reg_escr = "1001010" else '0';
hab_reg_escr(75) <= hab_escr when sel_reg_escr = "1001011" else '0';
hab_reg_escr(76) <= hab_escr when sel_reg_escr = "1001100" else '0';
hab_reg_escr(77) <= hab_escr when sel_reg_escr = "1001101" else '0';
hab_reg_escr(78) <= hab_escr when sel_reg_escr = "1001110" else '0';
hab_reg_escr(79) <= hab_escr when sel_reg_escr = "1001111" else '0';
hab_reg_escr(80) <= hab_escr when sel_reg_escr = "1010000" else '0';
hab_reg_escr(81) <= hab_escr when sel_reg_escr = "1010001" else '0';
hab_reg_escr(82) <= hab_escr when sel_reg_escr = "1010010" else '0';
hab_reg_escr(83) <= hab_escr when sel_reg_escr = "1010011" else '0';
hab_reg_escr(84) <= hab_escr when sel_reg_escr = "1010100" else '0';
hab_reg_escr(85) <= hab_escr when sel_reg_escr = "1010101" else '0';
hab_reg_escr(86) <= hab_escr when sel_reg_escr = "1010110" else '0';
hab_reg_escr(87) <= hab_escr when sel_reg_escr = "1010111" else '0';
hab_reg_escr(88) <= hab_escr when sel_reg_escr = "1011000" else '0';
hab_reg_escr(89) <= hab_escr when sel_reg_escr = "1011001" else '0';
hab_reg_escr(90) <= hab_escr when sel_reg_escr = "1011010" else '0';
hab_reg_escr(91) <= hab_escr when sel_reg_escr = "1011011" else '0';
hab_reg_escr(92) <= hab_escr when sel_reg_escr = "1011100" else '0';
hab_reg_escr(93) <= hab_escr when sel_reg_escr = "1011101" else '0';
hab_reg_escr(94) <= hab_escr when sel_reg_escr = "1011110" else '0';
hab_reg_escr(95) <= hab_escr when sel_reg_escr = "1011111" else '0';
hab_reg_escr(96) <= hab_escr when sel_reg_escr = "1100000" else '0';
hab_reg_escr(97) <= hab_escr when sel_reg_escr = "1100001" else '0';
hab_reg_escr(98) <= hab_escr when sel_reg_escr = "1100010" else '0';
hab_reg_escr(99) <= hab_escr when sel_reg_escr = "1100011" else '0';
hab_reg_escr(100) <= hab_escr when sel_reg_escr = "1100100" else '0';
hab_reg_escr(101) <= hab_escr when sel_reg_escr = "1100101" else '0';
hab_reg_escr(102) <= hab_escr when sel_reg_escr = "1100110" else '0';
hab_reg_escr(103) <= hab_escr when sel_reg_escr = "1100111" else '0';
hab_reg_escr(104) <= hab_escr when sel_reg_escr = "1101000" else '0';
hab_reg_escr(105) <= hab_escr when sel_reg_escr = "1101001" else '0';
hab_reg_escr(106) <= hab_escr when sel_reg_escr = "1101010" else '0';
hab_reg_escr(107) <= hab_escr when sel_reg_escr = "1101011" else '0';
hab_reg_escr(108) <= hab_escr when sel_reg_escr = "1101100" else '0';
hab_reg_escr(109) <= hab_escr when sel_reg_escr = "1101101" else '0';
hab_reg_escr(110) <= hab_escr when sel_reg_escr = "1101110" else '0';
hab_reg_escr(111) <= hab_escr when sel_reg_escr = "1101111" else '0';
hab_reg_escr(112) <= hab_escr when sel_reg_escr = "1110000" else '0';
hab_reg_escr(113) <= hab_escr when sel_reg_escr = "1110001" else '0';
hab_reg_escr(114) <= hab_escr when sel_reg_escr = "1110010" else '0';
hab_reg_escr(115) <= hab_escr when sel_reg_escr = "1110011" else '0';
hab_reg_escr(116) <= hab_escr when sel_reg_escr = "1110100" else '0';
hab_reg_escr(117) <= hab_escr when sel_reg_escr = "1110101" else '0';
hab_reg_escr(118) <= hab_escr when sel_reg_escr = "1110110" else '0';
hab_reg_escr(119) <= hab_escr when sel_reg_escr = "1110111" else '0';
hab_reg_escr(120) <= hab_escr when sel_reg_escr = "1111000" else '0';
hab_reg_escr(121) <= hab_escr when sel_reg_escr = "1111001" else '0';
hab_reg_escr(122) <= hab_escr when sel_reg_escr = "1111010" else '0';
hab_reg_escr(123) <= hab_escr when sel_reg_escr = "1111011" else '0';
hab_reg_escr(124) <= hab_escr when sel_reg_escr = "1111100" else '0';
hab_reg_escr(125) <= hab_escr when sel_reg_escr = "1111101" else '0';
hab_reg_escr(126) <= hab_escr when sel_reg_escr = "1111110" else '0';
hab_reg_escr(127) <= hab_escr when sel_reg_escr = "1111111" else '0';
end architecture;
