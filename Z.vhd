library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Z is
 port(

  Z_in : IN STD_LOGIC; -- load/enable.
  clr : IN STD_LOGIC; -- async. clear.
  clk : IN STD_LOGIC; -- clock.
  BusMuxOut : in std_logic_vector(63 downto 0); --64bit input
  BusMuxin1 : out std_logic_vector(31 downto 0); --32bit output
  BusMuxin0 : out std_logic_vector(31 downto 0)  --32bit output
 );
end entity;

architecture logic of Z is

begin

Z : process(clk, clr)
 begin
  
  if(clr = '0') then
   BusMuxin1 <= (others => '0');
   BusMuxin0 <= (others => '0');
  
  elsif(clk'event and clk = '1') then
   if(Z_in = '1') then
    BusMuxin1 <= BusMuxOut(63 downto 32);
    BusMuxin0 <= BusMuxOut(31 downto 0);
   end if;
  end if;
 end process;
end architecture;