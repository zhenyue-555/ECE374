library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity multiplier is
	port (
		inputA	: in std_logic_vector(31 downto 0);
		inputB	: in std_logic_vector(31 downto 0);
		output: out std_logic_vector(63 downto 0)
	);
end entity;

architecture behaviour of multiplier is
begin

behaviour : process(inputA, inputB) is

variable carry							: std_logic_vector(32 downto 0); -- used for carry
variable temp							: std_logic_vector(31 downto 0); -- used for storing negative
variable full, multiplicand		: std_logic_vector(63 downto 0);
variable mul, mul2, nmul, nmul2	: std_logic_vector(31 downto 0); -- booth algorithm multiplicands

begin
		carry(32 downto 1) := inputB;
		carry(0) := '0';
		full := x"0000000000000000";
		for i in 0 to 31 loop
			if (inputA(i) = '1') then
				nmul(i) := '0';
			elsif (inputA(i) = '0') then
				nmul(i) := '1';
			end if;
		end loop;
		nmul := std_logic_vector(unsigned(nmul) + x"00000001");
		mul2(31 downto 1) := inputA(30 downto 0);
		mul2(0) := '0';
		nmul2(31 downto 1) := nmul(30 downto 0);
		nmul2(0) := '0';
		for i in 0 to 15 loop
			if (carry(2 downto 0) = "000") then
				temp := x"00000000";
			elsif (carry(2 downto 0) = "001") then
				temp := inputA;
			elsif (carry(2 downto 0) = "010") then
				temp := inputA;
			elsif (carry(2 downto 0) = "011") then
				temp := mul2;
			elsif (carry(2 downto 0) = "100") then
				temp := nmul2;
			elsif (carry(2 downto 0) = "101") then
				temp := nmul;
			elsif (carry(2 downto 0) = "110") then
				temp := nmul;
			elsif (carry(2 downto 0) = "111") then
				temp := x"00000000";
			end if;
			multiplicand(63 downto 32) := temp;
			multiplicand(31 downto 0) := x"00000000";
			for j in 0 to (15 - i) loop
				multiplicand(61 downto 0) := multiplicand(63 downto 2);
				if (multiplicand(61) = '1') then
					multiplicand(63 downto 62) := "11";
				else
					multiplicand(63 downto 62) := "00";
				end if;
			end loop;
			full := full + multiplicand;
			carry(30 downto 0) := carry(32 downto 2);
		end loop;
		output <= full;
end process;
end architecture;