library ieee;
use ieee.std_logic_1164.all;

package ALU_component is 

component NOT_GATE is 

port (input: in std_logic_vector(31 downto 0);
		output: out std_logic_vector(31 downto 0)
);
end component NOT_GATE;

component division is

port (
		y: in std_logic;
    Ain: in std_logic_vector(31 downto 0); -- input for dividend
    Bin: in std_logic_vector(31 downto 0); -- input for divisor
    Q:  out std_logic_vector(63 downto 0); -- output for quotient
    remainder: out std_logic_vector(63 downto 0) -- output for remainder   
	);
end component division;

component negate is

port(input: in std_logic_vector(31 downto 0);
		 output: out std_logic_vector(31 downto 0)
	);
end component negate;

component adder is
port ( 
		 A_in: in std_logic_vector(31 downto 0);
		 B_in: in std_logic_vector(31 downto 0);
		 C_out: out std_logic;
		 C_in: in std_logic;
		 sum: out std_logic_vector(31 downto 0)
		 );
end component adder;

component MUL is 
GENERIC (x : INTEGER := 32;
   y : INTEGER := 32);
 
port (m : IN STD_LOGIC_VECTOR(x - 1 DOWNTO 0);
      q : IN STD_LOGIC_VECTOR(y - 1 DOWNTO 0);
      p : OUT STD_LOGIC_VECTOR(x + y - 1 DOWNTO 0);
    --mul_sel : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		i : IN STD_LOGIC
	);
end component MUL;

--component shifter is
--	port(
--		A : in std_logic_vector(31 downto 0);
--		res: out std_logic_vector(31	downto 0);
--		dire : in std_logic;
--		enable : in std_logic;
--	   n : in std_logic_vector(31 downto 0) 
--	);
--end component shifter;

component OR_Gate is

port (A: in std_logic_vector(31 downto 0);
		B : in std_logic_vector(31 downto 0);
		output: out std_logic_vector(31 downto 0)
);
end component OR_Gate;

component AND_Gate is

port (A: in std_logic_vector(31 downto 0);
		B : in std_logic_vector(31 downto 0);
		output: out std_logic_vector(31 downto 0)
);
end component AND_Gate;

component rotate is
	port(
		data : in std_logic_vector(31 downto 0);
		output: out std_logic_vector(31 downto 0);
		direction : in std_logic; ---left or right
		enable : in std_logic;
		d : in std_logic_vector(31 downto 0) 
	);
end component rotate;
end package;
