library ieee;
library work;
use ieee.std_logic_1164.all;


entity busmux is
port(
BusMuxIn_R0,BusMuxIn_R1,BusMuxIn_R2,BusMuxIn_R3,BusMuxIn_R4,BusMuxIn_R5,
BusMuxIn_R6,BusMuxIn_R7,BusMuxIn_R8,BusMuxIn_R9,BusMuxIn_R10,BusMuxIn_R11,
BusMuxIn_R12,BusMuxIn_R13,BusMuxIn_R14,BusMuxIn_R15,BusMuxIn_HI,BusMuxIn_LO,
BusMuxIn_Zhigh,BusMuxIn_Zlow,BusMuxIn_PC,BusMuxIn_MDR,BusMuxIn_IN_PORT,C_sign_extended
: in std_logic_vector(31 downto 0);
Sin: in std_logic_vector(4 downto 0);
BusMuxOut: out std_logic_vector(31 downto 0)
);

end entity busmux;

architecture behavior of busmux is

begin 

  with Sin select
  BusMuxOut <= BusMuxIn_R0 when "00000",
  BusMuxIn_R1 when "00001",
  BusMuxIn_R2 when "00010",
  BusMuxIn_R3 when "00011",
  BusMuxIn_R4 when "00100",
  BusMuxIn_R5 when "00101",
  BusMuxIn_R6 when "00110",
  BusMuxIn_R7 when "00111",
  BusMuxIn_R8 when "01000",
  BusMuxIn_R9 when "01001",
  BusMuxIn_R10 when "01010",
  BusMuxIn_R11 when "01011",
  BusMuxIn_R12 when "01100",
  BusMuxIn_R13 when "01101",
  BusMuxIn_R14 when "01110",
  BusMuxIn_R15 when "01111",
  BusMuxIn_HI when "10000",
  BusMuxIn_LO when "10001",
  BusMuxIn_Zhigh when "10010",
  BusMuxIn_Zlow when "10011",
  BusMuxIn_PC when "10100",
  BusMuxIn_MDR when "10101",
  BusMuxIn_IN_PORT when "10110",
  C_sign_extended when "10111",
  (others => '0') when others;

end architecture behavior;