LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY alu_encoder IS
	PORT(
		AND_i: IN STD_LOGIC :='0';
		OR_i: IN STD_LOGIC :='0';
		NOT_i: IN STD_LOGIC :='0';
		NEG_i: IN STD_LOGIC :='0';
		ADD_i: IN STD_LOGIC :='0';
		SUB_i: IN STD_LOGIC :='0';
		MUL_i: IN STD_LOGIC :='0';
		DIV_i: IN STD_LOGIC :='0';
		SHR_i: IN STD_LOGIC :='0';
		SHL_i: IN STD_LOGIC :='0';
		ROR_i: IN STD_LOGIC :='0';
		ROL_i: IN STD_LOGIC :='0';
		ALU_SEL: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE behavioral of alu_encoder IS

SIGNAL s1: STD_LOGIC_VECTOR(11 DOWNTO 0):=(others => '0');
SIGNAL s2: STD_LOGIC_VECTOR(3 DOWNTO 0):=(others =>'0');

BEGIN

s1(0) <= AND_i;
s1(1) <= OR_i;
s1(2) <= NOT_i;
s1(3) <= NEG_i;
s1(4) <= ADD_i;
s1(5) <= SUB_i;
s1(6) <= MUL_i;
s1(7) <= DIV_i;
s1(8) <= SHR_i;
s1(9) <= SHL_i;
s1(10) <= ROR_i;
s1(11) <= ROL_i;

	PROCESS(s1)
	BEGIN
	IF(s1 = "000000000001")THEN
		s2 <="0000";
	ELSIF(s1 = "000000000010")THEN
		s2 <="0001";
	ELSIF(s1 = "000000000100")THEN
		s2 <="0010";
	ELSIF(s1 = "000000001000")THEN
		s2 <="0011";
	ELSIF(s1 = "000000010000")THEN
		s2 <="0100";
	ELSIF(s1 = "000000100000")THEN
		s2 <="0101";
	ELSIF(s1 = "000001000000")THEN
		s2 <="0110";
	ELSIF(s1 = "000010000000")THEN
		s2 <="0111";
	ELSIF(s1 = "000100000000")THEN
		s2 <="1000";
	ELSIF(s1 = "001000000000")THEN
		s2 <="1001";
	ELSIF(s1 = "010000000000")THEN
		s2 <="1010";
	ELSIF(s1 = "100000000000")THEN
		s2 <="1011";
	ELSE
		s2 <= "ZZZZ";
	END IF;
	END PROCESS;
ALU_SEL <= s2;
END ARCHITECTURE;