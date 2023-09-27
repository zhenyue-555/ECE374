LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY Y_reg IS

PORT(
BusMuxOut : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- input.
Y_in : IN STD_LOGIC; -- load/enable.
clr : IN STD_LOGIC; -- async. clear.
clk : IN STD_LOGIC; -- clock.
Alu_in : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output.
);

end Y_reg;

architecture behaviour OF Y_reg IS
 
BEGIN

   process(clk, clr)
   begin
      if (clr = '0') then 
         Alu_in <= (others =>'0');
  elsif clk'event and clk ='1' then
  --elsif (rising_edge(clk)) then
     if (Y_in = '1') then
        Alu_in <= BusMuxOut;
         end if;
     end if;
   end process;
END architecture;