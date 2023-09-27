library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity encoder_32to5 is
 port(
	x0 : in std_logic;
	x1 : in std_logic;
	x2 : in std_logic;
	x3 : in std_logic;
	x4 : in std_logic;
	x5 : in std_logic;
	x6 : in std_logic;
	x7 : in std_logic;
	x8 : in std_logic;
	x9 : in std_logic;
	x10 : in std_logic;
	x11 : in std_logic;
	x12 : in std_logic;
	x13 : in std_logic;
	x14 : in std_logic;
	x15 : in std_logic;
	x16 : in std_logic;
	x17 : in std_logic;
	x18 : in std_logic;
	x19 : in std_logic;
	x20 : in std_logic;
	x21 : in std_logic;
	x22 : in std_logic;
	x23 : in std_logic;
	x24 : in std_logic;
	x25 : in std_logic;
	x26 : in std_logic;
	x27 : in std_logic;
	x28 : in std_logic;
	x29 : in std_logic;
	x30 : in std_logic;
	x31 : in std_logic;
	sel0 : out std_logic;
	sel1 : out std_logic;
	sel2 : out std_logic;
	sel3 : out std_logic;
	sel4 : out std_logic
 );
end entity;
 
architecture behavior of encoder_32to5 is

signal a : std_logic_vector(31 downto 0):= (others => '0');
signal b : std_logic_vector(4 downto 0) := (others => '0');

begin

a(0) <= x0;
a(1) <= x1;
a(2) <= x2;
a(3) <= x3;
a(4) <= x4;
a(5) <= x5;
a(6) <= x6;
a(7) <= x7;
a(8) <= x8;
a(9) <= x9;
a(10) <= x10;
a(11) <= x11;
a(12) <= x12;
a(13) <= x13;
a(14) <= x14;
a(15) <= x15;
a(16) <= x16;
a(17) <= x17;
a(18) <= x18;
a(19) <= x19;
a(20) <= x20;
a(21) <= x21;
a(22) <= x22;
a(23) <= x23;
a(24) <= x24;
a(25) <= x25;
a(26) <= x26;
a(27) <= x27;
a(28) <= x28;
a(29) <= x29;
a(30) <= x30;
a(31) <= x31;

with a select
b <= "00000" when "00000000000000000000000000000001",
		"00001" when "00000000000000000000000000000010",
		"00010" when "00000000000000000000000000000100",
		"00011" when "00000000000000000000000000001000",		
		"00100" when "00000000000000000000000000010000",		
		"00101" when "00000000000000000000000000100000",		
		"00110" when "00000000000000000000000001000000",
		"00111" when "00000000000000000000000010000000",
		"01000" when "00000000000000000000000100000000",
		"01001" when "00000000000000000000001000000000",		
		"01010" when "00000000000000000000010000000000",		
		"01011" when "00000000000000000000100000000000",		
		"01100" when "00000000000000000001000000000000",		
		"01101" when "00000000000000000010000000000000",		
		"01110" when "00000000000000000100000000000000",		
		"01111" when "00000000000000001000000000000000",		
		"10000" when "00000000000000010000000000000000",		
		"10001" when "00000000000000100000000000000000",		
		"10010" when "00000000000001000000000000000000",		
		"10011" when "00000000000010000000000000000000",		
		"10100" when "00000000000100000000000000000000",		
		"10101" when "00000000001000000000000000000000",		
		"10110" when "00000000010000000000000000000000",		
		"10111" when "00000000100000000000000000000000",		
		"11000" when "00000001000000000000000000000000",		
		"11001" when "00000010000000000000000000000000",		
		"11010" when "00000100000000000000000000000000",		
		"11011" when "00001000000000000000000000000000",	
		"11100" when "00010000000000000000000000000000",	
		"11101" when "00100000000000000000000000000000",	
		"11110" when "01000000000000000000000000000000",
		"11111" when "10000000000000000000000000000000",
		"ZZZZZ" when others;
sel0 <= b(0);
sel1 <= b(1);
sel2 <= b(2);
sel3 <= b(3);
sel4 <= b(4);	
end architecture;