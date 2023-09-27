LIBRARY ieee;
USE ieee.std_logic_1164.all; 
LIBRARY work;


ENTITY LO IS 
generic (VAL : std_logic_vector(31 downto 0) := x"00000000");
 PORT
 (
  clk :  IN  STD_LOGIC;
  clr :  IN  STD_LOGIC;
  LO_in :  IN  STD_LOGIC;
  BusMuxOut :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
  BusMuxIn_LO :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0) := VAL
 );
END ENTITY;

ARCHITECTURE bdf_type OF LO IS 

COMPONENT register32
 PORT(
        BusMuxOut : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- input.
        reg32_in : IN STD_LOGIC; -- load/enable.
        clr : IN STD_LOGIC; -- async. clear.
        clk : IN STD_LOGIC; -- clock.
        BusMuxIn_reg32 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output.
 );
END COMPONENT;


BEGIN 

b2v_inst : register32
PORT MAP(clk => clk,
         clr => clr,
         reg32_in => LO_in, 
         BusMuxOut => BusMuxOut,
         BusMuxIn_reg32 => BusMuxIn_LO); 

END bdf_type;