--LIBRARY ieee;
--USE ieee.std_logic_1164.ALL;
--USE ieee.std_logic_signed.ALL;
--use ieee.numeric_std.all;
--
--ENTITY MUL IS
--
-- GENERIC (x : INTEGER := 32;
--          y : INTEGER := 32);
-- 
-- PORT(m : IN STD_LOGIC_VECTOR(x - 1 DOWNTO 0);
--      q : IN STD_LOGIC_VECTOR(y - 1 DOWNTO 0);
--      p : OUT STD_LOGIC_VECTOR(x + y - 1 DOWNTO 0)
--      --i : IN STD_LOGIC
-- );   
--END MUL;
--
--ARCHITECTURE behavior OF MUL IS
--
--BEGIN
--
--
--
-- PROCESS(m,q) 
-- variable Pos1, Neg1, zero:  std_logic_vector(31 downto 0);
-- variable Output, Result, Pos2, Neg2: std_logic_vector(63 downto 0);
-- variable temp: std_logic;
-- variable tempM : std_logic_vector(63 downto 0);
-- 
-- BEGIN
-- tempM := x"00000000" & m;
-- Pos1 := m;
-- Neg1:= (0-m);
-- Output := x"0000000000000000";
-- Zero := x"00000000";
-- Pos2 := STD_LOGIC_VECTOR(shift_left(unsigned(tempM),1));
-- Neg2 := STD_LOGIC_VECTOR(shift_left(unsigned(0-tempM),1));
-- 
--
-- 
-- for i in 0 to 15 loop
-- 
--	 
--    if(i = 0) then
--	    if(q(i*2+1 downto i*2) = "00")then
--		    Result(31 downto 0) := Zero;
--			 temp := Result(31);
--			 
--		 elsif(q(i*2+1 downto i*2) = "01")then
--		    Result(31 downto 0) := Pos1;
--			 temp := Result(31);
--			 
--		 elsif(q(i*2+1 downto i*2) = "10")then
--		    Result := Neg2;
--			 temp := Result(32);
--			 
--		 else
--		    Result(31 downto 0) := Neg1;
--			 temp := Result(31);
--			 
--		 end if;
--
--	
--	else
--	   if(q(i*2+1 downto i*2-1) = "000")then
--         Result(31 downto 0) := Zero;
--			temp := Result(31);
--			
--		elsif(q(i*2+1 downto i*2-1)= "001")then
--		   Result(31 downto 0) := Pos1;
--			temp := Result(31);
--		
--		elsif(q(i*2+1 downto i*2-1)= "010")then
--		   Result(31 downto 0) := Pos1;
--			temp := Result(31);
--
--		elsif(q(i*2+1 downto i*2-1) = "011")then
--		   Result:= Pos2;
--			temp := Result(32);
--			
--		elsif(q(i*2+1 downto i*2-1) = "100")then
--		   Result:= Neg2;			
--			temp := Result(32);
--			
--		elsif(q(i*2+1 downto i*2-1) = "101")then
--		   Result(31 downto 0):= Neg1;					 
--			temp := Result(31);
--			
--		elsif(q(i*2+1 downto i*2-1) = "110")then
--		   Result(31 downto 0):= Neg1;				 
--			temp := Result(31);
--			
--		elsif(q(i*2+1 downto i*2-1) = "111")then
--		   Result(31 downto 0):= Zero;
--			temp := Result(31);
--			
--	   end if;
--		
--    end if;
--	 
--	 if(temp = '1')then
--	    Result(63 downto 32) := x"FFFFFFFF";
--	 else
--	    Result(63 downto 32) := x"00000000";
--	 end if;
--	 
--	 Result := STD_LOGIC_VECTOR(shift_left(unsigned(Result),i));
--	 
--	 Output := Output + Result;
--	 
--end loop;
--
--   p <= Output;
--
-- END PROCESS;
-- 
--END behavior;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity MUL is
	port (
		inputA	: in std_logic_vector(31 downto 0);
		inputB	: in std_logic_vector(31 downto 0);
		output: out std_logic_vector(63 downto 0)
	);
end entity;

architecture behaviour of MUL is
begin

behaviour : process(inputA, inputB) is

variable carry							: std_logic_vector(32 downto 0); -- used for carry
variable temp							: std_logic_vector(31 downto 0); -- used for storing negative
variable full, multiplicand		: std_logic_vector(63 downto 0);
variable mul, mul2, nmul, nmul2	: std_logic_vector(31 downto 0); -- booth algorithm multiplicands

begin
		carry(32 downto 1) := inputB;
		carry(0) := '0';
		full := x"0000000000000000";
		for i in 0 to 31 loop
			if (inputA(i) = '1') then
				nmul(i) := '0';
			elsif (inputA(i) = '0') then
				nmul(i) := '1';
			end if;
		end loop;
		nmul := std_logic_vector(unsigned(nmul) + x"00000001");
		mul2(31 downto 1) := inputA(30 downto 0);
		mul2(0) := '0';
		nmul2(31 downto 1) := nmul(30 downto 0);
		nmul2(0) := '0';
		for i in 0 to 15 loop
			if (carry(2 downto 0) = "000") then
				temp := x"00000000";
			elsif (carry(2 downto 0) = "001") then
				temp := inputA;
			elsif (carry(2 downto 0) = "010") then
				temp := inputA;
			elsif (carry(2 downto 0) = "011") then
				temp := mul2;
			elsif (carry(2 downto 0) = "100") then
				temp := nmul2;
			elsif (carry(2 downto 0) = "101") then
				temp := nmul;
			elsif (carry(2 downto 0) = "110") then
				temp := nmul;
			elsif (carry(2 downto 0) = "111") then
				temp := x"00000000";
			end if;
			multiplicand(63 downto 32) := temp;
			multiplicand(31 downto 0) := x"00000000";
			for j in 0 to (15 - i) loop
				multiplicand(61 downto 0) := multiplicand(63 downto 2);
				if (multiplicand(61) = '1') then
					multiplicand(63 downto 62) := "11";
				else
					multiplicand(63 downto 62) := "00";
				end if;
			end loop;
			full := full + multiplicand;
			carry(30 downto 0) := carry(32 downto 2);
		end loop;
		output <= full;
end process;
end architecture;