LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY bidirectional_bus IS 
	PORT
	(
		R0out :  IN  STD_LOGIC;
		R1out :  IN  STD_LOGIC;
		R2out :  IN  STD_LOGIC;
		R3out :  IN  STD_LOGIC;
		R4out :  IN  STD_LOGIC;
		R5out :  IN  STD_LOGIC;
		R6out :  IN  STD_LOGIC;
		R7out :  IN  STD_LOGIC;
		R8out :  IN  STD_LOGIC;
		R9out :  IN  STD_LOGIC;
		R10out :  IN  STD_LOGIC;
		R11out :  IN  STD_LOGIC;
		R12out :  IN  STD_LOGIC;
		R13out :  IN  STD_LOGIC;
		R14out :  IN  STD_LOGIC;
		R15out :  IN  STD_LOGIC;
		PCout :  IN  STD_LOGIC;
		HIout :  IN  STD_LOGIC;
		LOout :  IN  STD_LOGIC;
		Zhighout :  IN  STD_LOGIC;
		Zlowout :  IN  STD_LOGIC;
		MDRout :  IN  STD_LOGIC;
		InPortout :  IN  STD_LOGIC;
		Cout :  IN  STD_LOGIC;
		
		BusMuxIn_R0,BusMuxIn_R1,BusMuxIn_R2,BusMuxIn_R3,BusMuxIn_R4,BusMuxIn_R5,
BusMuxIn_R6,BusMuxIn_R7,BusMuxIn_R8,BusMuxIn_R9,BusMuxIn_R10,BusMuxIn_R11,
BusMuxIn_R12,BusMuxIn_R13,BusMuxIn_R14,BusMuxIn_R15,BusMuxIn_HI,BusMuxIn_LO,
BusMuxIn_Zhigh,BusMuxIn_Zlow,BusMuxIn_PC,BusMuxIn_MDR,BusMuxIn_IN_PORT,C_sign_extended
: in std_logic_vector(31 downto 0);

		BusMuxOut :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END bidirectional_bus;

ARCHITECTURE bdf_type OF bidirectional_bus IS 

COMPONENT encoder_32to5
	PORT(x0 : IN STD_LOGIC;
		 x1 : IN STD_LOGIC;
		 x2 : IN STD_LOGIC;
		 x3 : IN STD_LOGIC;
		 x4 : IN STD_LOGIC;
		 x5 : IN STD_LOGIC;
		 x6 : IN STD_LOGIC;
		 x7 : IN STD_LOGIC;
		 x8 : IN STD_LOGIC;
		 x9 : IN STD_LOGIC;
		 x10 : IN STD_LOGIC;
		 x11 : IN STD_LOGIC;
		 x12 : IN STD_LOGIC;
		 x13 : IN STD_LOGIC;
		 x14 : IN STD_LOGIC;
		 x15 : IN STD_LOGIC;
		 x16 : IN STD_LOGIC;
		 x17 : IN STD_LOGIC;
		 x18 : IN STD_LOGIC;
		 x19 : IN STD_LOGIC;
		 x20 : IN STD_LOGIC;
		 x21 : IN STD_LOGIC;
		 x22 : IN STD_LOGIC;
		 x23 : IN STD_LOGIC;
		 x24 : IN STD_LOGIC;
		 x25 : IN STD_LOGIC;
		 x26 : IN STD_LOGIC;
		 x27 : IN STD_LOGIC;
		 x28 : IN STD_LOGIC;
		 x29 : IN STD_LOGIC;
		 x30 : IN STD_LOGIC;
		 x31 : IN STD_LOGIC;
		 sel0 : OUT STD_LOGIC;
		 sel1 : OUT STD_LOGIC;
		 sel2 : OUT STD_LOGIC;
		 sel3 : OUT STD_LOGIC;
		 sel4 : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT mux32to1_32
	PORT(
		 SEL0 : IN STD_LOGIC;
		 SEL1 : IN STD_LOGIC;
		 SEL2 : IN STD_LOGIC;
		 SEL3 : IN STD_LOGIC;
		 SEL4 : IN STD_LOGIC;
		 X0_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X1_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X2_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X3_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X4_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X5_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X6_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X7_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X8_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X9_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X10_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X11_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X12_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X13_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X14_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X15_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X16_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X17_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X18_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X19_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X20_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X21_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X22_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X23_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X24_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X25_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X26_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X27_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X28_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X29_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X30_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 X31_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 Y_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;

BEGIN 

b2v_DataSelectEncoder : encoder_32to5
PORT MAP(x0 => R0out,
		 x1 => R1out,
		 x2 => R2out,
		 x3 => R3out,
		 x4 => R4out,
		 x5 => R5out,
		 x6 => R6out,
		 x7 => R7out,
		 x8 => R8out,
		 x9 => R9out,
		 x10 => R10out,
		 x11 => R11out,
		 x12 => R12out,
		 x13 => R13out,
		 x14 => R14out,
		 x15 => R15out,
		 x16 => HIout,
		 x17 => LOout,
		 x18 => Zhighout,
		 x19 => Zlowout,
		 x20 => PCout,
		 x21 => MDRout,
		 x22 => InPortout,
		 x23 => Cout,
		 x24 => '0',
		 x25 => '0',
		 x26 => '0',
		 x27 => '0',
		 x28 => '0',
		 x29 => '0',
		 x30 => '0',
		 x31 => '0',
		 sel0 => SYNTHESIZED_WIRE_0,
		 sel1 => SYNTHESIZED_WIRE_1,
		 sel2 => SYNTHESIZED_WIRE_2,
		 sel3 => SYNTHESIZED_WIRE_3,
		 sel4 => SYNTHESIZED_WIRE_4);

b2v_DataOutMux : mux32to1_32
PORT MAP(SEL0 => SYNTHESIZED_WIRE_0,
		 SEL1 => SYNTHESIZED_WIRE_1,
		 SEL2 => SYNTHESIZED_WIRE_2,
		 SEL3 => SYNTHESIZED_WIRE_3,
		 SEL4 => SYNTHESIZED_WIRE_4,
		 X0_in => BusMuxIn_R0,
		 X1_in => BusMuxIn_R1,
		 X2_in => BusMuxIn_R2,
		 X3_in => BusMuxIn_R3,
		 X4_in => BusMuxIn_R4,
		 X5_in => BusMuxIn_R5,
		 X6_in => BusMuxIn_R6,
		 X7_in => BusMuxIn_R7,
		 X8_in => BusMuxIn_R8,
		 X9_in => BusMuxIn_R9,
		 X10_in => BusMuxIn_R10,
		 X11_in => BusMuxIn_R11,
		 X12_in => BusMuxIn_R12,
		 X13_in => BusMuxIn_R13,
		 X14_in => BusMuxIn_R14,
		 X15_in => BusMuxIn_R15,
		 X16_in => BusMuxIn_HI,
		 X17_in => BusMuxIn_LO,
		 X18_in => BusMuxIn_Zhigh,
		 X19_in => BusMuxIn_Zlow,
		 X20_in => BusMuxIn_PC,
		 X21_in => BusMuxIn_MDR,
		 X22_in => BusMuxIn_IN_PORT,
		 X23_in => C_sign_extended,
		 X24_in => "00000000000000000000000000000000",
		 X25_in => "00000000000000000000000000000000",
		 X26_in => "00000000000000000000000000000000",
		 X27_in => "00000000000000000000000000000000",
		 X28_in => "00000000000000000000000000000000",
		 X29_in => "00000000000000000000000000000000",
		 X30_in => "00000000000000000000000000000000",
		 X31_in => "00000000000000000000000000000000",
		 Y_out => BusMuxOut);

END bdf_type;