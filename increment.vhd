library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity increment is

port (input: in std_logic_vector(31 downto 0);
		output: out std_logic_vector(31 downto 0)
);
end entity increment;


architecture beh of increment is
component adder port(A_in: in std_logic_vector(31 downto 0);
							B_in: in std_logic_vector(31 downto 0);
							C_out: out std_logic;
							C_in: in std_logic;
							sum: out std_logic_vector(31 downto 0));
end component adder;

begin 
increment_adder : adder port map(
							A_in => input,
							B_in => x"00000000",
							C_in => '1',
							sum => output

);

end architecture beh;