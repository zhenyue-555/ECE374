library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity ALUSelect is

port (
	ADD_i : IN STD_LOGIC_VECTOR(3 downto 0) :="0000" ;
	SUB_i : IN STD_LOGIC_VECTOR(3 downto 0) :="0001" ;
	MUL_i : IN STD_LOGIC_VECTOR(3 downto 0) :="0010" ;
	DIV_i : IN STD_LOGIC_VECTOR(3 downto 0) :="0011" ;
	SHR_i : IN STD_LOGIC_VECTOR(3 downto 0) :="0100" ;
	SHL_i : IN STD_LOGIC_VECTOR(3 downto 0) :="0101" ;
	ROR_i : IN STD_LOGIC_VECTOR(3 downto 0) :="0110" ;
	ROL_i : IN STD_LOGIC_VECTOR(3 downto 0) :="0111" ;
	AND_i : IN STD_LOGIC_VECTOR(3 downto 0) :="1000" ;
	OR_i : IN STD_LOGIC_VECTOR(3 downto 0) :="1001" ;
	NEG_i : IN STD_LOGIC_VECTOR(3 downto 0) :="1010" ;
	NOT_i : IN STD_LOGIC_VECTOR(3 downto 0) :="1011" ;
	result : OUT STD_LOGIC_VECTOR(3 downto 0)

);
end ALUSelect;

architecture behavior of ALUSelect is

signal i,o : STD_LOGIC_VECTOR(3 downto 0);
begin
process(i,o)
begin
case(i) is
when "0000" =>
o <= i;
when "0001" =>
o <= i;
when "0010" =>
o <= i;
when "0011" =>
o <= i;
when "0100" =>
o <= i;
when "0101" =>
o <= i;
when "0110" =>
o <= i;
when "0111" =>
o <= i;
when "1000" =>
o <= i;
when "1001" =>
o  <= i;
when "1010" =>
o <= i;
when "1011" =>
o <= i;
when others =>
o <= "0000";
 end case;
 end process;
 result <= o;
end architecture;