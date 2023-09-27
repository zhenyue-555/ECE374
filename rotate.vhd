library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity rotate is 
 port(
  data : in std_logic_vector(31 downto 0);
  output: out std_logic_vector(31 downto 0);
  direction : in std_logic; ---left or right
  enable : in std_logic;
    d : in std_logic_vector(31 downto 0) 
 );
end entity;

architecture behavior of rotate is
signal b : natural;
signal d_temp : std_logic_vector(3 downto 0);
begin
d_temp <= d(3 downto 0);
b <= to_integer(unsigned(d_temp));

process(b, data, direction, enable)
begin
 output <= (others => '0');
if (enable = '1') then
 if b = 0 then
  output <= data;
 else
  if(direction = '0') then -- rotate left
   output(31 downto b) <= data(31 - b downto 0);
   output(b - 1 downto 0) <=data(31 downto 31+1-b);
  else
   output(31 downto 31-b+1) <= data(b-1 downto 0); --rotate right
   output(31-b downto 0) <= data(31 downto b);
  end if;
 end if;
else 
 output <= (others => '0');
end if;
end process;
end architecture;