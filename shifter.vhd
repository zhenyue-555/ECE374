library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity shifter is 
 port(
  A : in std_logic_vector(31 downto 0);
  en : in std_logic;
  d : in std_logic;
  n : in std_logic_vector(31 downto 0);
  output: out std_logic_vector(31 downto 0)
 );
end entity;
 
architecture behavior of shifter is
signal bits : integer;
signal sign : std_logic;
signal n_temp : std_logic_vector(3 downto 0);

begin
n_temp <= n(3 downto 0);
bits <= to_integer(unsigned(n_temp ));
simprocess: process (A, d,bits, en) is 
begin

output <= (others => '0');
if (en = '1') then
if bits = 0 then
 output <= A;
else
 if d = '0' then 
  output(31 downto bits) <= A(31-bits downto 0);
  output(bits-1 downto 0) <= (others => '0');
 else
  
  if A(31)  = '0' then
   output(31 downto 31-bits+1) <= (others => '0');
  else
   output(31 downto 31-bits+1) <= (others => '1');
  end if;
  output(31-bits downto 0) <= A(31 downto bits);

 end if;
end if;
else
 output <= (others => '0');
end if;
end process;

end architecture;