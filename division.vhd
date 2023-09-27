library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity division is 
port( 
    Ain: in std_logic_vector(31 downto 0); -- input for dividend
    Bin: in std_logic_vector(31 downto 0); -- input for divisor
    Q:  out std_logic_vector(31 downto 0); -- output for quotient
    remainder: out std_logic_vector(31 downto 0) -- output for remainder   
);
end entity;

architecture behavior of division is 
    begin
    process(Ain,Bin)
        variable counter: integer;
        variable tempAin: std_logic_vector(63 downto 0);
        begin
        tempAin := x"00000000" & Ain;
        counter :=0;
        while(counter<32) loop
            counter:=counter+1; 
	         tempAin(63 downto 1):= tempAin(62 downto 0);
	         tempAin(0):='0';
	         tempAin(63 downto 32) := tempAin(63 downto 32) - Bin;
            
		      if (tempAin(63) = '1') then
		         tempAin(63 downto 32) := tempAin(63 downto 32) + Bin;
		      else
			      tempAin(0) := '1';
		      end if;
        end loop;
		  
            Q <= tempAin(31 downto 0);
            remainder <= tempAin(63 downto 32);
    end process;
end behavior;