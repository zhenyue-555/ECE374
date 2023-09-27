library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity negate is
 port (input: in std_logic_vector(31 downto 0);
		 output: out std_logic_vector(31 downto 0)
);
 
end entity;


architecture behavior of negate is
begin

 process(input)
 variable temp : std_logic_vector(31 downto 0);
 begin
  for i in 0 to 31 loop
  
  if input(i) = '1'  then
   temp(i) := '0';
  else
   temp(i) :='1';
  end if;
   
  end loop;
  output <= std_logic_vector(signed(temp) + 1);
 end process;
end architecture behavior;
  
  
