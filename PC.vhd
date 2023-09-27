LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


ENTITY PC IS

PORT(
BusMuxOut : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- input.
PC_in : IN STD_LOGIC; -- load/enable.
IncPC : IN STD_LOGIC; 
clr : IN STD_LOGIC; -- async. clear.
clk : IN STD_LOGIC; -- clock.
BusMuxIn_PC : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output.
);

end PC;

architecture behaviour OF PC IS


component increment is 
port (input: in std_logic_vector(31 downto 0);
		output: out std_logic_vector(31 downto 0)
);
end component increment;
signal temp  :  std_logic_vector(31 downto 0);
BEGIN

PC_increment : increment port map
(
				input => BusMuxOut, 
				output => temp
);
   process(clk, clr)


   begin
 
      if (clr = '0') then 
         BusMuxIn_PC <= (others =>'0');
      elsif clk'event and clk ='1' then
      --elsif (rising_edge(clk)) then
         if (PC_in = '1') then
           if(IncPC = '1')then
                 BusMuxIn_PC <= temp ;
         else
             BusMuxIn_PC <= BusMuxOut;
             end if;
         end if;
  end if;
   end process;
END architecture;