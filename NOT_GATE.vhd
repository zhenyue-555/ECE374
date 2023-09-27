library ieee;
use ieee.std_logic_1164.all;

entity NOT_GATE IS 

port (input: in std_logic_vector(31 downto 0);
  output: out std_logic_vector(31 downto 0)
);
end entity;

architecture behavior of NOT_GATE is
begin
 process(input)
 begin
  for i in 0 to 31 loop
  
  if input(i) = '1'  then
   output(i) <= '0';
  else
   output(i) <='1';
  end if;
   
  end loop;
 end process;
end architecture behavior;