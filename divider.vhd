library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity divider is
	port (
		inputA	: in std_logic_vector(31 downto 0);
		inputB	: in std_logic_vector(31 downto 0);
		quotient: out std_logic_vector(31 downto 0);
		remainder: out std_logic_vector(31 downto 0)
	);
end entity;

architecture behaviour of divider is
begin

behaviour	: process(inputA, inputB) is

variable full		: std_logic_vector(63 downto 0);

begin
		
		full(63 downto 32) := x"00000000"; -- restoring division
		full(31 downto 0) := inputA;
		for i in 0 to 31 loop
			full(63 downto 1) := full(62 downto 0);
			full(0) := '0';
			full(63 downto 32) := full(63 downto 32) - inputB;
			if (full(63) = '1') then
				full(63 downto 32) := full(63 downto 32) + inputB;
			else
				full(0) := '1';
			end if;
		end loop;
		quotient <= full(31 downto 0);
		remainder <= full(63 downto 32);
		
end process;
end architecture;