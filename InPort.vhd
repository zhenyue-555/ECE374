LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY InPort is
generic (VAL : std_logic_vector(31 downto 0) := x"00000000");
port(
InputUnit : in std_logic_vector(31 downto 0);
clr : in std_logic;
clk : in std_logic;
InPortin : in std_logic;
BusMuxIn_IN_PORT : out std_logic_vector(31 downto 0) := VAL
);
end entity InPort;

architecture behaviour of InPort is
begin
process(clk, clr, InPortin)
begin 
  if(clr = '0')then
     BusMuxIn_IN_PORT <= (others =>'0');
  elsif clk'event and clk ='1' then
     if(InPortin = '1') then
	     BusMuxIn_IN_PORT <= InputUnit;
	  end if;
  end if;
  end process;
end architecture;
