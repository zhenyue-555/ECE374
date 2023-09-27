library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mux32to1_32 is
port( 
	SEL0 : in std_logic; -- Selection vector bit 0
	SEL1 : in std_logic; -- 1
	SEL2 : in std_logic; -- 2
	SEL3 : in std_logic; -- 3
	SEL4 : in std_logic; -- 4
	X0_in : in std_logic_vector(31 downto 0); -- Input vector 0
	X1_in : in std_logic_vector(31 downto 0); -- 1
	X2_in : in std_logic_vector(31 downto 0); -- 2
	X3_in : in std_logic_vector(31 downto 0); -- 3
	X4_in : in std_logic_vector(31 downto 0); -- 4
	X5_in : in std_logic_vector(31 downto 0); -- 5
	X6_in : in std_logic_vector(31 downto 0); -- 6
	X7_in : in std_logic_vector(31 downto 0); -- 7
	X8_in : in std_logic_vector(31 downto 0); -- 8
	X9_in : in std_logic_vector(31 downto 0); -- 9
	X10_in : in std_logic_vector(31 downto 0); -- 10
	X11_in : in std_logic_vector(31 downto 0); -- 11
	X12_in : in std_logic_vector(31 downto 0); -- 12
	X13_in : in std_logic_vector(31 downto 0); -- 13
	X14_in : in std_logic_vector(31 downto 0); -- 14
	X15_in : in std_logic_vector(31 downto 0); -- 15
	X16_in : in std_logic_vector(31 downto 0); -- 16
	X17_in : in std_logic_vector(31 downto 0); -- 17
	X18_in : in std_logic_vector(31 downto 0); -- 18
	X19_in : in std_logic_vector(31 downto 0); -- 19
	X20_in : in std_logic_vector(31 downto 0); -- 20
	X21_in : in std_logic_vector(31 downto 0); -- 21
	X22_in : in std_logic_vector(31 downto 0); -- 22
	X23_in : in std_logic_vector(31 downto 0); -- 23
	X24_in : in std_logic_vector(31 downto 0); -- 24
	X25_in : in std_logic_vector(31 downto 0); -- 25
	X26_in : in std_logic_vector(31 downto 0); -- 26
	X27_in : in std_logic_vector(31 downto 0); -- 27
	X28_in : in std_logic_vector(31 downto 0); -- 28
	X29_in : in std_logic_vector(31 downto 0); -- 29
	X30_in : in std_logic_vector(31 downto 0); -- 30
	X31_in : in std_logic_vector(31 downto 0); -- 31
	Y_out : out std_logic_vector(31 downto 0) -- Output
);

end entity mux32to1_32;

architecture behaviour of mux32to1_32 is

signal SEL : std_logic_vector(4 downto 0);

begin

SEL(0) <= SEL0;
SEL(1) <= SEL1;
SEL(2) <= SEL2;
SEL(3) <= SEL3;
SEL(4) <= SEL4;

with SEL select
Y_out <= X0_in when "00000",
			X1_in when "00001",
			X2_in when "00010",
			X3_in when "00011",
			X4_in when "00100",
			X5_in when "00101",
			X6_in when "00110",
			X7_in when "00111",
			X8_in when "01000",
			X9_in when "01001",
			X10_in when "01010",
			X11_in when "01011",
			X12_in when "01100",
			X13_in when "01101",
			X14_in when "01110",
			X15_in when "01111", 
	 		X16_in when "10000",
	 		X17_in when "10001",
			X18_in when "10010",
	 		X19_in when "10011",
	 		X20_in when "10100",
	 		X21_in when "10101",
	 		X22_in when "10110",
	 		X23_in when "10111",
	 		X24_in when "11000",
	 		X25_in when "11001",
	 		X26_in when "11010",
	 		X27_in when "11011",
	 		X28_in when "11100",
	 		X29_in when "11101",
	 		X30_in when "11110", 
	 		X31_in when "11111",
			"00000000000000000000000000000000" when others;

end architecture; 