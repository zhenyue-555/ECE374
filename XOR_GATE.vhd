library ieee;
use ieee.std_logic_1164.all;

entity XOR_GATE IS 
generic (num : positive := 31);
port (A: in std_logic_vector(num downto 0);
  B : in std_logic_vector(num downto 0);
  output: out std_logic_vector(num downto 0)
);
end entity;

architecture behavior of XOR_GATE is
begin
 process(A, B)
 begin
  for i in 0 to num loop
  
  if A(i) = B(i)  then
   output(i) <= '0';
  else
   output(i) <='1';
  end if;
   
  end loop;
 end process;
end architecture behavior;