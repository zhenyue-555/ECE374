library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity adder is
	port ( 
		A : in std_logic_vector (31 downto 0);
		B : in std_logic_vector (31 downto 0);
		Cin : in std_logic;
		S : out std_logic_vector (31 downto 0);
		Cout : out std_logic
	);
end entity;

architecture behavior of adder is

signal sum_internal : std_logic_vector (31 downto 0);
signal carry_generate : std_logic_vector (31 downto 0);
signal carry_propagate : std_logic_vector (31 downto 0);
signal carry_in_internal : std_logic_vector (31 downto 1);

begin

sum_internal <= A xor B;
carry_generate <= A and B;
carry_propagate <= A or B;

	process (carry_generate,carry_propagate,carry_in_internal)
	begin
   
	carry_in_internal(1) <= carry_generate(0) or (carry_propagate(0) and Cin);
		
	inst: for i in 1 to 30 loop
		carry_in_internal(i+1) <= carry_generate(i) or (carry_propagate(i) and carry_in_internal(i));
   end loop;
   
	Cout <= carry_generate(31) or (carry_propagate(31) and carry_in_internal(31));
   end process;

S(0) <= sum_internal(0) xor Cin;
S(31 downto 1) <= sum_internal(31 downto 1) xor carry_in_internal(31 downto 1);
end architecture;