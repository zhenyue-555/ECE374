library ieee;
use ieee.std_logic_1164.all;

entity AND_GATE IS 

port (A: in std_logic_vector(31 downto 0);
  B : in std_logic_vector(31 downto 0);
  output: out std_logic_vector(31 downto 0)
);
end entity;

architecture behavior of AND_GATE is
begin
 process(A, B)
 begin
  for i in 0 to 31 loop
   if A(i) = '1' and  B(i) = '1' then
    output(i) <= '1';
   else
    output(i) <='0';
   end if;
  end loop;
 end process;
end architecture behavior;