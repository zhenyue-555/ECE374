library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity ALU_encoder is
 port(
 I1 : in std_logic;
 I2 : in std_logic;
 I3 : in std_logic;
 I4 : in std_logic;
 I5 : in std_logic;
 I6 : in std_logic;
 I7 : in std_logic;
 I8 : in std_logic;
 I9 : in std_logic;
 I10 : in std_logic;
 I11 : in std_logic;
 I12 : in std_logic;
 
 output : out std_logic_vector(3 downto 0) 
 );  
end entity;

ARCHITECTURE behavior of ALU_encoder is
BEGIN
the_encoder : process (I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12)
begin
  IF(I1 = '1' and I2 = '0'and I3 = '0'and I4 = '0'and I5 = '0' and I6 = '0'and I7 = '0'and I8 = '0'and I9 = '0'and I10 = '0'and I11 = '0'and I12 = '0')THEN
  output <= "0000";
  ELSIF(I1 = '0' and I2 = '1'and I3 = '0'and I4 = '0'and I5 = '0' and I6 = '0'and I7 = '0'and I8 = '0'and I9 = '0'and I10 = '0'and I11 = '0'and I12 = '0')THEN
  output <= "0001";
  ELSIF(I1 = '0' and I2 = '0'and I3 = '1'and I4 = '0'and I5 = '0' and I6 = '0'and I7 = '0'and I8 = '0'and I9 = '0'and I10 = '0'and I11 = '0'and I12 = '0')THEN
  output <= "0010";
  ELSIF(I1 = '0' and I2 = '0'and I3 = '0'and I4 = '1'and I5 = '0' and I6 = '0'and I7 = '0'and I8 = '0'and I9 = '0'and I10 = '0'and I11 = '0'and I12 = '0')THEN
  output <= "0011";
  ELSIF(I1 = '0' and I2 = '0'and I3 = '0'and I4 = '0'and I5 = '1' and I6 = '0'and I7 = '0'and I8 = '0'and I9 = '0'and I10 = '0'and I11 = '0'and I12 = '0')THEN
  output <= "0100";
  ELSIF(I1 = '0' and I2 = '0'and I3 = '0'and I4 = '0'and I5 = '0' and I6 = '1'and I7 = '0'and I8 = '0'and I9 = '0'and I10 = '0'and I11 = '0'and I12 = '0')THEN
  output <= "0101";
  ELSIF(I1 = '0' and I2 = '0'and I3 = '0'and I4 = '0'and I5 = '0' and I6 = '0'and I7 = '1'and I8 = '0'and I9 = '0'and I10 = '0'and I11 = '0'and I12 = '0')THEN
  output <= "0110";
  ELSIF(I1 = '0' and I2 = '0'and I3 = '0'and I4 = '0'and I5 = '0' and I6 = '0'and I7 = '0'and I8 = '1'and I9 = '0'and I10 = '0'and I11 = '0'and I12 = '0')THEN
  output <= "0111";
  ELSIF(I1 = '0' and I2 = '0'and I3 = '0'and I4 = '0'and I5 = '0' and I6 = '0'and I7 = '0'and I8 = '0'and I9 = '1'and I10 = '0'and I11 = '0'and I12 = '0')THEN
  output <= "1000"; 
  ELSIF(I1 = '0' and I2 = '0'and I3 = '0'and I4 = '0'and I5 = '0' and I6 = '0'and I7 = '0'and I8 = '0'and I9 = '0'and I10 = '1'and I11 = '0'and I12 = '0')THEN
  output <= "1001"; 
  ELSIF(I1 = '0' and I2 = '0'and I3 = '0'and I4 = '0'and I5 = '0' and I6 = '0'and I7 = '0'and I8 = '0'and I9 = '0'and I10 = '0'and I11 = '1'and I12 = '0')THEN
  output <= "1010"; 
  ELSIF(I1 = '0' and I2 = '0'and I3 = '0'and I4 = '0'and I5 = '0' and I6 = '0'and I7 = '0'and I8 = '0'and I9 = '0'and I10 = '0'and I11 = '0'and I12 = '1')THEN
  output <= "1011"; 
  ELSE
  output <= "1111";
  
  end if;
 end process;
 end architecture;