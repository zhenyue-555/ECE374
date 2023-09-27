--library ieee ;
--use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
--
--entity mux2to1_32 is
--port( 
--	SelectBit: in std_logic; -- selection bit input
--	input1: in std_logic_vector(31 downto 0); -- first input
--	input2: in std_logic_vector(31 downto 0); -- second input
--	output: out std_logic_vector(31 downto 0)  -- output	
--);
--
--end entity mux2to1_32;
--
--architecture mux2to1_32_arch of mux2to1_32 is
--begin
--
--   with SelectBit select
--      output <= input2 when '1',
--		input1 when others;
--
--end architecture mux2to1_32_arch; 





library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mux2to1_32 is
port( 
	SEL: in std_logic; -- selection bit input
	X0_in: in std_logic_vector(31 downto 0); -- first input
	X1_in: in std_logic_vector(31 downto 0); -- second input
	Y: out std_logic_vector(31 downto 0)  -- output
);

end entity mux2to1_32;

architecture mux2to1_32_arch of mux2to1_32 is
begin

with SEL select
Y <= X1_in when '1',
		X0_in when others;

end architecture mux2to1_32_arch; 