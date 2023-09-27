library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity division is 
port(
    y: in std_logic;
    Ain: in std_logic_vector(31 downto 0); -- input for dividend
    Bin: in std_logic_vector(31 downto 0); -- input for divisor
    Q:  out std_logic_vector(63 downto 0); -- output for quotient
    remainder: out std_logic_vector(63 downto 0) -- output for remainder   
);
end entity;

architecture behavior of division is 
signal tempA, tempB:std_logic_vector(31 downto 0);
signal sign, negSign,d: std_logic;

begin
    d <= (Ain(31) xor Bin(31)) and y;
    sign <= Ain(31) and y;
    process(Ain,Bin,y)
        begin
        if(y = '1') then
            if Ain(31) = '1' then
                tempA <= not Ain+1;
            else
                tempA <= Ain;
            end if;
            if Bin(31) = '1' then
                tempB <= not Bin +1;
            else
                tempB <= Bin;
            end if;
        else
            tempA<=Ain;
            tempB<=Bin;
        end if;
        end process;
    
    process(tempA,tempB,negSign,sign)
        variable counter: integer;
        variable tempAin, tempBin: std_logic_vector(63 downto 0);
        begin
        tempAin := x"00000000" & tempA;
        tempBin := tempB & x"00000000";
        counter :=0;
        while(counter<32) loop
            tempAin:=tempAin(62 downto 0) &"0";
            counter:=counter+1; 
            if tempAin(63 downto 32) >= tempB then
                tempAin:=tempAin - tempBin +1;
            end if;
        end loop;
        if(d ='1') then
            tempAin(31 downto 0):=(not tempAin(31 downto 0)) +1;
        end if;
        if(sign = '1') then 
            tempAin(63 downto 32):=(not tempBin(63 downto 32)) + 1;
        end if;
        Q <= x"00000000" & tempAin(31 downto 0);
        remainder <= tempAin(63 downto 32) & x"00000000";
    end process;
    end;