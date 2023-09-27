library ieee;
use ieee.std_logic_1164.all;

entity OR_GATE IS 

port (A: in std_logic_vector(31 downto 0);
  B : in std_logic_vector(31 downto 0);
  output: out std_logic_vector(31 downto 0)
);
end entity;

architecture behavior of OR_GATE is
begin
 process(A, B)
 begin
  for i in 0 to 31 loop
   if A(i) = '0' and  B(i) = '0' then
    output(i) <= '0';
   else
    output(i) <='1';
   end if;
  end loop;
 end process;
end architecture behavior;