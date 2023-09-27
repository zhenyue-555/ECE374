library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity subtractor is
  Port(
    A_in: in std_logic_vector(31 downto 0);
    B_in: in std_logic_vector(31 downto 0);
    C_out: out std_logic;
  C_in: in std_logic;
    result: out std_logic_vector(31 downto 0)
  );
end entity subtractor;

architecture behavior of subtractor is

signal gen: std_logic_vector(31 downto 0);
signal prop: std_logic_vector(31 downto 0);
signal Carry: std_logic_vector(32 downto 0);
begin 
    gen <= A_in AND (not B_in + 1);
    prop <= A_in OR (not B_in + 1);
    Carry(0) <= C_in;
    process(gen, prop,Carry)
    begin
        for i in 1 to 32 loop
            Carry(i) <= gen(i-1) or (prop(i-1) and Carry(i-1));
        end loop;
    end process;
    result <= A_in XOR (not B_in + 1) XOR Carry(31 downto 0);
    C_out <= Carry(32);
end architecture;