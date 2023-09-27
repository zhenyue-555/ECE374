LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.ALL;
use ieee.numeric_std.all;

ENTITY SHL IS

 GENERIC (x : INTEGER := 32;
          y : INTEGER := 32);
 
 PORT(input1 : IN STD_LOGIC_VECTOR(x - 1 DOWNTO 0);
      input2 : IN STD_LOGIC_VECTOR(x - 1 DOWNTO 0); -- the number of bits that is shifted by
      output : OUT STD_LOGIC_VECTOR(x - 1 DOWNTO 0)
 ); 
 
END SHL;

ARCHITECTURE behavior OF SHL IS

BEGIN

 PROCESS(input1, input2) 
 
 variable temp: integer;
 
 begin
 temp := to_integer(unsigned(input2));
  
 output(31 downto temp) <= input1(31 - temp downto 0); 
 output(temp - 1 downto 0) <= (others => '0');
 
 end process;
 
end behavior;