--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.std_logic_signed.all;
--
--entity adder is
--  Port(
--    A_in: in std_logic_vector(31 downto 0);
--    B_in: in std_logic_vector(31 downto 0);
--    C_out: out std_logic;
--  C_in: in std_logic;
--    sum: out std_logic_vector(31 downto 0)
--  );
--end entity adder;
--
--architecture behavior of adder is
--
--signal gen: std_logic_vector(31 downto 0);
--signal prop: std_logic_vector(31 downto 0);
--signal Carry: std_logic_vector(32 downto 0);
--begin 
--    gen <= A_in AND B_in;
--    prop <= A_in OR B_in;
--    Carry(0) <= C_in;
--    process(gen, prop,Carry)
--    begin
--        for i in 1 to 32 loop
--            Carry(i) <= gen(i-1) or (prop(i-1) and Carry(i-1));
--        end loop;
--    end process;
--    sum <= A_in XOR B_in XOR Carry(31 downto 0);
--    C_out <= Carry(32);
--end architecture;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY adder IS
 
generic (N : integer := 31);
 PORT
 (
 A_in : IN STD_LOGIC_VECTOR (N DOWNTO 0);
 B_in : IN STD_LOGIC_VECTOR (N DOWNTO 0);
 C_in : IN STD_LOGIC;
 sum : OUT STD_LOGIC_VECTOR(N DOWNTO 0);
 C_out : OUT STD_LOGIC
 );
END adder;
ARCHITECTURE behavioral OF adder IS
SIGNAL h_sum : STD_LOGIC_VECTOR (N DOWNTO 0);
SIGNAL carry_generate : STD_LOGIC_VECTOR (N DOWNTO 0);
SIGNAL carry_propagate : STD_LOGIC_VECTOR (N DOWNTO 0);
SIGNAL carry_in_internal : STD_LOGIC_VECTOR(N DOWNTO 1);
BEGIN
 h_sum <= A_in XOR B_in;
 carry_generate <= A_in AND B_in;
 carry_propagate <= A_in OR B_in;
 
 PROCESS (carry_generate,carry_propagate,carry_in_internal)
 BEGIN
 carry_in_internal(1) <= carry_generate(0) OR (carry_propagate(0) AND C_in);
 inst: FOR i IN 1 TO (N-1) LOOP
 carry_in_internal(i+1) <= carry_generate(i) OR (carry_propagate(i) AND carry_in_internal(i));
 END LOOP;
 C_out <= carry_generate(N) OR (carry_propagate(N) AND carry_in_internal(N));
 END PROCESS;
 sum(0) <= h_sum(0) XOR C_in;
 sum(N DOWNTO 1) <= h_sum(N DOWNTO 1) XOR carry_in_internal(N DOWNTO 1);
END behavioral;