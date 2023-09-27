LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity CONFF is
port(
   BusMuxOut : in std_logic_vector(31 downto 0);
   clr : in std_logic;
   clk : in std_logic;
   CONin : in std_logic; --load/enable
   IRout : in std_logic_vector(31 downto 0);
   CONFFout : out std_logic
);
end entity CONFF;

architecture behave of CONFF is

signal decoder_in : std_logic_vector(1 downto 0);
signal decoder_out : std_logic_vector(3 downto 0);
signal BusNorOutput : std_logic;
signal zero, nonzero, positive1, negative1 : std_logic;
signal OrOutput : std_logic;


begin

decoder_in <= IRout(20 downto 19);
   decoder_out <= "0001" when decoder_in = "00" else
                  "0010" when decoder_in = "01" else
	               "0100" when decoder_in = "10" else 
	               "1000" when decoder_in = "11";
	
	BusNorOutput <= '1' 
	when (BusMuxOut = "00000000000000000000000000000000") 
	else '0';

	
	zero <= decoder_out(0) and BusNorOutput;
	nonzero <= decoder_out(1) and (not BusNorOutput);
	positive1 <= decoder_out(2) and (not BusMuxOut(31));
	negative1 <= decoder_out(3) and BusMuxOut(31);	
	OrOutput <= zero or nonzero or positive1 or negative1;


process(clk, CONin)
  begin
    if(clr = '0') then
	     CONFFout <= '0';
    elsif clk'event and clk ='1' then
	     if(CONin = '1')then
		      CONFFout <= OrOutput;
		  end if;
	end if;
  end process;
end architecture;
	
	
	
	


