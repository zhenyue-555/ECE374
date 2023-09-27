library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;


entity ALU is
  
    Port (
    A, B     : in  STD_LOGIC_VECTOR(31 downto 0);  -- 2 inputs 8-bit
    ALU_Sel  : in  STD_LOGIC_VECTOR(3 downto 0);  -- 1 input 4-bit for selecting function
    ALU_Out   : out  STD_LOGIC_VECTOR(63 downto 0); -- 1 output 64-bit 
    Carryout : out std_logic        -- Carryout flag
	 
    );
end ALU; 
architecture Behavioral of ALU is
component NOT_GATE is 

port (input: in std_logic_vector(31 downto 0);
		output: out std_logic_vector(31 downto 0)
);
end component NOT_GATE;

component division is

port (
		
    Ain: in std_logic_vector(31 downto 0); -- input for dividend
    Bin: in std_logic_vector(31 downto 0); -- input for divisor
    Q:  out std_logic_vector(63 downto 0); -- output for quotient
    remainder: out std_logic_vector(63 downto 0) -- output for remainder   
	);
end component division;

component negate is

port(input: in std_logic_vector(31 downto 0);
		 output: out std_logic_vector(31 downto 0)
	);
end component negate;

component adder is
port ( 
		 A_in: in std_logic_vector(31 downto 0);
		 B_in: in std_logic_vector(31 downto 0);
		C_out: out std_logic;
		C_in: in std_logic;
		sum: out std_logic_vector(31 downto 0)
		 );
end component adder;
component subtractor is
port ( 
		 A_in: in std_logic_vector(31 downto 0);
		 B_in: in std_logic_vector(31 downto 0);
		 result: out std_logic_vector(31 downto 0)
		 );
end component subtractor;


component MUL is 
GENERIC (x : INTEGER := 32;
   y : INTEGER := 32);
 
port (m : IN STD_LOGIC_VECTOR(x - 1 DOWNTO 0);
      q : IN STD_LOGIC_VECTOR(y - 1 DOWNTO 0);
      p : OUT STD_LOGIC_VECTOR(x + y - 1 DOWNTO 0)
    
	);
end component MUL;

component SHR is

 GENERIC (x : INTEGER := 32;
          y : INTEGER := 32);
 
 PORT(input1 : IN STD_LOGIC_VECTOR(x - 1 DOWNTO 0);
      input2 : IN STD_LOGIC_VECTOR(x - 1 DOWNTO 0); -- the number of bits that is shifted by
      output : OUT STD_LOGIC_VECTOR(x - 1 DOWNTO 0)
 ); 
 
END component SHR;
component SHL is

 GENERIC (x : INTEGER := 32;
          y : INTEGER := 32);
 
 PORT(input1 : IN STD_LOGIC_VECTOR(x - 1 DOWNTO 0);
      input2 : IN STD_LOGIC_VECTOR(x - 1 DOWNTO 0); -- the number of bits that is shifted by
      output : OUT STD_LOGIC_VECTOR(x - 1 DOWNTO 0)
 ); 
 
END component SHL;
component OR_Gate is

port (A: in std_logic_vector(31 downto 0);
		B : in std_logic_vector(31 downto 0);
		output: out std_logic_vector(31 downto 0)
);
end component OR_Gate;

component AND_Gate is

port (A: in std_logic_vector(31 downto 0);
		B : in std_logic_vector(31 downto 0);
		output: out std_logic_vector(31 downto 0)
);
end component AND_Gate;

component RR is
	port(
		--enable : in std_logic;
		data : in std_logic_vector(31 downto 0);
		output: out std_logic_vector(31 downto 0);
		d : in std_logic_vector(31 downto 0) 
	);
end component RR;	

component RL is
	port(
		--enable : in std_logic;
		data : in std_logic_vector(31 downto 0);
		output: out std_logic_vector(31 downto 0);
		d : in std_logic_vector(31 downto 0) 
	);	
end component RL;

--signal sub_output : std_LOGIC_VECTOR(31 downto 0);
--signal add_output : std_LOGIC_VECTOR(31 downto 0);
signal shift_output_right : std_LOGIC_VECTOR(31 downto 0);
signal shift_output_left : std_LOGIC_VECTOR(31 downto 0);
signal rotate_output_right : std_LOGIC_VECTOR(31 downto 0);
signal rotate_output_left : std_LOGIC_VECTOR(31 downto 0);
--signal multiple_output : std_logic_vector(15 downto 0);
signal negate_out : std_LOGIC_VECTOR(31 downto 0);
signal not_output : std_LOGIC_VECTOR(31 downto 0);
signal or_output : std_LOGIC_VECTOR(31 downto 0);
signal and_output : std_LOGIC_VECTOR(31 downto 0);
signal division_quotient : std_logic_vector(63 downto 0);
signal division_remainder : std_logic_vector(63 downto 0);
signal mult_output : std_LOGIC_VECTOR(63 downto 0);
--signal PCresult : std_LOGIC_VECTOR(31 downto 0);
signal ALU_Result : std_logic_vector (63 downto 0);
signal tmp: std_logic_vector (32 downto 0);
signal COUT: std_logic;


   begin 
--map all components

--ALU_add : adder
--port map(
--		A_in	=> A,	
--		B_in	=> B,
--		C_out => COUT,	
--		C_in => '0',
--		sum => add_output	
--		
--	);
	
--ALU_sub : subtractor
--port map(
--		A_in	=> A,
--		B_in	=> B,
--		result => sub_output
--		);



ALU_shift_logical_right : SHR--right
port map(
		input1	=> A,		
		input2	=> B,
		output => shift_output_right		
);

ALU_shift_logical_left : SHL --left
port map(
		input1	=> A,		
		input2	=> B,
		output => shift_output_left		
);

ALU_rotateR : RR --rotate 
port map(
		--enable => clk,
		data => A,
		d => B,
		output => rotate_output_right
);
ALU_rotateL : RL--rotate 
port map(
		--enable => clk,
		data => A,
		d => B,
		output => rotate_output_left
);


ALU_negate : negate
port map(
		input => A,
		output => negate_out
);


ALU_multiply : MUL
port map(
		m => A,
		q => B,
		p => mult_output
);

ALU_signed_division : division
port map(
		Bin => B,
		Ain => A,
		Q => division_quotient,
		remainder => division_remainder
);

ALU_not_gate : NOT_GATE
port map(
		input => A,
		output => not_output
);

ALU_or_gate : OR_GATE
port map(
		A => A,
		B => B,
		output => or_output
);
ALU_and_gate : AND_GATE
port map(
		A => A,
		B => B,
		output => and_output
);
   process(A,B,ALU_Sel,ALU_result)
 begin
  ALU_result <= x"0000000000000000";
  case(ALU_Sel) is
  when "0000" => -- Addition
  ALU_Result(63 downto 32) <= (others =>'0');
  ALU_Result(31 downto 0)  <=  std_logic_vector(unsigned(A) + unsigned(B));
   
  when "0001" => -- Subtraction
  ALU_Result(63 downto 32) <= (others =>'0');
  ALU_Result(31 downto 0)  <= std_logic_vector(unsigned(A) - unsigned(B));
  
  when "0010" => -- Multiplication
  ALU_Result(63 downto 32) <= (others =>'0');
  ALU_Result <= mult_output;
  
  when "0011" => -- Division
  ALU_Result(63 downto 32) <= division_remainder(31 downto 0);
  ALU_Result(31 downto 0) <= division_quotient(31 downto 0);
  
  when "0100" => -- Logical shift left
  ALU_Result(63 downto 32) <= (others =>'0');
  ALU_Result(31 downto 0)  <= shift_output_left;
  
  when "0101" => -- Logical shift right
  ALU_Result(63 downto 32) <= (others =>'0');
  ALU_Result(31 downto 0)  <= shift_output_right;
  
  when "0110" => --  Rotate left
  ALU_Result(63 downto 32) <= (others =>'0');
  ALU_Result(31 downto 0)  <= rotate_output_left;
  
  when "0111" => -- Rotate right
  ALU_Result(63 downto 32) <= (others =>'0');
  ALU_Result(31 downto 0)  <= rotate_output_right;
  
  when "1000" => -- Logical and 
  ALU_Result(63 downto 32) <= (others =>'0');
  ALU_Result(31 downto 0)  <= and_output;
  
  when "1001" => -- Logical or
  ALU_Result(63 downto 32) <= (others =>'0');
  ALU_Result(31 downto 0)  <= or_output;
  
  when "1010" => -- negate
  ALU_Result(63 downto 32) <= (others =>'0');
  ALU_Result(31 downto 0)  <= negate_out;
  
  when "1011" => -- not
  ALU_Result(63 downto 32) <= (others =>'0');
  ALU_Result(31 downto 0)  <= not_output;
  when others => ALU_Result <= (others =>'0'); 
  end case;
 end process;
 ALU_Out <= ALU_Result; -- ALU out
 tmp <= ('0' & A) + ('0' & B);
 Carryout <= tmp(32); -- Carryout flag
end Behavioral;