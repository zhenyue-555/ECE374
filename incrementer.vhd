library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

---------------------------------------------------

entity incrementer is
port(
	input: in std_logic_vector (31 downto 0);
	output: out std_logic_vector (31 downto 0)
);

end entity;

----------------------------------------------------

architecture behavior of incrementer is

component adder
	port (
		A : in std_logic_vector	(31 downto 0);
		B : in std_logic_vector	(31 downto 0);
		Cin : in std_logic;
		S : out std_logic_vector (31 downto 0);
		Cout : out std_logic
	);
end component;

begin

cl_addr_1 : adder port map (
	input,
	"00000000000000000000000000000000",
	'1',
	output
	);

end architecture; 