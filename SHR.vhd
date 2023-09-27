LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.ALL;
use ieee.numeric_std.all;

ENTITY SHR IS

 GENERIC (x : INTEGER := 32;
          y : INTEGER := 32);
 
 PORT(input1 : IN STD_LOGIC_VECTOR(x - 1 DOWNTO 0);
      input2 : IN STD_LOGIC_VECTOR(x - 1 DOWNTO 0); -- the number of bits that is shifted by
      output : OUT STD_LOGIC_VECTOR(x - 1 DOWNTO 0)
 ); 
 
END SHR;

ARCHITECTURE behavior OF SHR IS

BEGIN

 PROCESS(input1, input2) 
 
 variable temp: integer;
 
 begin
 temp := to_integer(unsigned(input2));
  
 output(31 - temp downto 0) <= input1(31 downto temp); 
 if input1(31)  = '1' then
    output(31 downto 31-temp+1) <= (others => '1');
 else
    output(31 downto 31-temp+1) <= (others => '0');
 end if;
 end process;
 
end behavior;