LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY register32 IS

PORT(
BusMuxOut : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- input.
reg32_in : IN STD_LOGIC; -- load/enable.
clr : IN STD_LOGIC; -- async. clear.
clk : IN STD_LOGIC; -- clock.
BusMuxIn_reg32 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output.
);

end register32;

architecture behaviour OF register32 IS
 
BEGIN

   process(clk, clr)
   begin
      if (clr = '0') then 
         BusMuxIn_reg32 <= (others =>'0');
  elsif clk'event and clk ='1' then
  --elsif (rising_edge(clk)) then
     if (reg32_in = '1') then
        BusMuxIn_reg32 <= BusMuxOut;
         end if;
     end if;
   end process;
END architecture;