LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY work;


ENTITY IR IS
generic (VAL : std_logic_vector(31 downto 0) := x"00000000");
PORT(
IR_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- input.
IR_en : IN STD_LOGIC; -- load/enable.
clr : IN STD_LOGIC; -- async. clear.
clk : IN STD_LOGIC; -- clock.
IR_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) := VAL -- output.
);

end ENTITY;

architecture behaviour OF IR IS
 
BEGIN

   process(clk, clr)
   begin
      if (clr = '0') then 
         IR_out <= (others =>'0');
  elsif clk'event and clk ='1' then
     if (IR_en = '1') then
        IR_out <= IR_in;
         end if;
     end if;
   end process;
END architecture;