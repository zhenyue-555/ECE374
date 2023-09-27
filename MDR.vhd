LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY work;

ENTITY MDR IS
generic (VAL : std_logic_vector(31 downto 0) := x"00000000");
PORT(
    busMuxOut: IN std_logic_vector(31 downto 0);
    Mdatain:    IN std_logic_vector(31 downto 0);
    clr:        IN std_logic;
    clk:        IN std_logic;
    MDRin:      IN std_logic;
    Read_s:     IN std_logic;
    BusMuxIn_MDR: OUT std_logic_vector(31 downto 0) := VAL
);
END MDR;

ARCHITECTURE behavioral OF MDR IS

COMPONENT mux2to1_32 IS
PORT(
--	SelectBit: in std_logic; -- selection bit input
--	input1: in std_logic_vector(31 downto 0); -- first input
--	input2: in std_logic_vector(31 downto 0); -- second input
--	output: out std_logic_vector(31 downto 0)  -- output	
	
	SEL: in std_logic; -- selection bit input
	X0_in: in std_logic_vector(31 downto 0); -- first input
	X1_in: in std_logic_vector(31 downto 0); -- second input
	Y: out std_logic_vector(31 downto 0)  -- output
);
END COMPONENT;

COMPONENT register32
PORT(
 clr : IN STD_LOGIC; -- async. clear.
 clk : IN STD_LOGIC; -- clock.
 BusMuxOut : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- input.
 reg32_in : IN STD_LOGIC; -- load/enable.
 BusMuxIn_reg32 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output.
);
END COMPONENT;

SIGNAL s1: STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN


read_select: mux2to1_32
PORT MAP(SEL => Read_s,
         X0_in => BusMuxOut,
         X1_in => MdataIn,
         Y => s1
);


mdr_reg: register32
PORT MAP(BusMuxOut => s1,
         reg32_in => MDRin,
         clr => clr,
         clk => clk,
         BusMuxIn_reg32 => BusMuxIn_MDR
);

END behavioral;
