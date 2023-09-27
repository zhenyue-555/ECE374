LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY MAR IS

PORT(
MAR_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- input.
MAR_en : IN STD_LOGIC; -- load/enable.
clr : IN STD_LOGIC; -- async. clear.
clk : IN STD_LOGIC; -- clock.
MAR_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output.
);

end MAR;

architecture behaviour OF MAR IS
 
BEGIN

   process(clk, clr)
   begin
      if (clr = '0') then 
         MAR_out <= (others =>'0');
  elsif clk'event and clk ='1' then
  --elsif (rising_edge(clk)) then
     if (MAR_en = '1') then
        MAR_out <= MAR_in;
         end if;
     end if;
   end process;
END architecture;