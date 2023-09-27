library ieee;
use ieee.std_logic_1164.all;
LIBRARY work;
use work.typeState.all;
entity datapath2 is
port(

Clock : IN STD_LOGIC; 
Run : OUT STD_LOGIC;
Reset : IN STD_LOGIC; 
Stop : IN STD_LOGIC;

clear : INOUT STD_LOGIC; 
HIin : INOUT  STD_LOGIC;
LOin : INOUT  STD_LOGIC;
PCin : INOUT STD_LOGIC;
IRin : INOUT STD_LOGIC;
Zin : INOUT STD_LOGIC;
Yin : INOUT STD_LOGIC;
MARin : INOUT STD_LOGIC;
MDRin : INOUT STD_LOGIC;
InPortin : INOUT STD_LOGIC;
Read : INOUT STD_LOGIC;
IncPC : INOUT STD_LOGIC;

HIout : INOUT STD_LOGIC;
LOout : INOUT STD_LOGIC;
Zhighout : INOUT STD_LOGIC;
Zlowout : INOUT STD_LOGIC;
PCout : INOUT STD_LOGIC;
MDRout : INOUT STD_LOGIC;
InPortout : INOUT STD_LOGIC;
Cout : INOUT STD_LOGIC;

ADD_i : INOUT STD_LOGIC;
SUB_i : INOUT STD_LOGIC;
MUL_i : INOUT STD_LOGIC;
DIV_i : INOUT STD_LOGIC;
SHR_i : INOUT STD_LOGIC;
SHL_i : INOUT STD_LOGIC;
ROR_i : INOUT STD_LOGIC;
ROL_i : INOUT STD_LOGIC;
AND_i : INOUT STD_LOGIC;
OR_i : INOUT STD_LOGIC;
NEG_i : INOUT STD_LOGIC;
NOT_i : INOUT STD_LOGIC;

BusMuxOut1 : OUT std_logic_vector(31 downto 0);
Statevalue : OUT State;
Write_i : INOUT STD_LOGIC;
OutPortin : INOUT STD_LOGIC;
Gra: INOUT STD_LOGIC;
Grb: INOUT STD_LOGIC;
Grc: INOUT STD_LOGIC;
Rin: INOUT STD_LOGIC;
Rout: INOUT STD_LOGIC;
BAout: INOUT STD_LOGIC;
CONin : INOUT std_logic; --load/enable
CON_FF : INOUT std_logic;
InputUnit : in std_logic_vector(31 downto 0);
OutputUnit : out std_logic_vector(31 downto 0);
IRout :  INOUT STD_LOGIC_VECTOR(31 DOWNTO 0);
R14in_enable : INOUT STD_LOGIC
);
end entity datapath2;

architecture behavior of datapath2 is

component register32 is
generic (VAL : std_logic_vector(31 downto 0) := x"00000000");
PORT(
BusMuxOut : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- input.
reg32_in : IN STD_LOGIC; -- load/enable.
clr : IN STD_LOGIC; -- async. clear.
clk : IN STD_LOGIC; -- clock.
BusMuxIn_reg32 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) := VAL-- output.
);
end component register32;

component encoder is
port( 
R0out,R1out,R2out,R3out,R4out,R5out,R6out,R7out,R8out,R9out,
R10out,R11out,R12out,R13out,R14out,R15out,HIout,LOout,Zhighout,Zlowout,
PCout,MDRout,InPortout,Cout: in std_logic;
o : out std_logic_vector(4 downto 0) 
 );  
end component encoder;

component busmux is
port(
BusMuxIn_R0,BusMuxIn_R1,BusMuxIn_R2,BusMuxIn_R3,BusMuxIn_R4,BusMuxIn_R5,
BusMuxIn_R6,BusMuxIn_R7,BusMuxIn_R8,BusMuxIn_R9,BusMuxIn_R10,BusMuxIn_R11,
BusMuxIn_R12,BusMuxIn_R13,BusMuxIn_R14,BusMuxIn_R15,BusMuxIn_HI,BusMuxIn_LO,
BusMuxIn_Zhigh,BusMuxIn_Zlow,BusMuxIn_PC,BusMuxIn_MDR,BusMuxIn_IN_PORT,
C_sign_extended: in std_logic_vector(31 downto 0);
Sin: in std_logic_vector(4 downto 0);
BusMuxOut: out std_logic_vector(31 downto 0) 
);
end component busmux;

component ALU_encoder is
 port(
 		AND_i: IN STD_LOGIC;
		OR_i: IN STD_LOGIC;
		NOT_i: IN STD_LOGIC;
		NEG_i: IN STD_LOGIC;
		ADD_i: IN STD_LOGIC;
		SUB_i: IN STD_LOGIC;
		MUL_i: IN STD_LOGIC;
		DIV_i: IN STD_LOGIC;
		SHR_i: IN STD_LOGIC;
		SHL_i: IN STD_LOGIC;
		ROR_i: IN STD_LOGIC;
		ROL_i: IN STD_LOGIC;
		ALU_SEL: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
 );  
end component;

component ALU is
    Port (
	 	A,B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		ALU_sel: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		C_HI: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		C_LO: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
end component ALU; 


component MDR is
generic (VAL : std_logic_vector(31 downto 0) := x"00000000");
PORT(	 
	 busMuxOut: IN std_logic_vector(31 downto 0);
    Mdatain:    IN std_logic_vector(31 downto 0);
    clr:        IN std_logic;
    clk:        IN std_logic;
    MDRin:      IN std_logic;
    Read_s:     IN std_logic;
    BusMuxIn_MDR: OUT std_logic_vector(31 downto 0) := VAL
);
END component MDR;


component MAR is
generic (VAL : std_logic_vector(31 downto 0) := x"00000000");
PORT(
MAR_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- input.
MAR_en : IN STD_LOGIC; -- load/enable.
clr : IN STD_LOGIC; -- async. clear.
clk : IN STD_LOGIC; -- clock.
MAR_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) := VAL -- output.
);
end component MAR;


component HI is
generic (VAL : std_logic_vector(31 downto 0) := x"00000000");
 PORT
 (
  clk :  IN  STD_LOGIC;
  clr :  IN  STD_LOGIC;
  HI_in :  IN  STD_LOGIC;
  BusMuxOut :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0) := VAL;
  BusMuxIn_HI :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0) := VAL
 );
END component HI;


component LO is
generic (VAL : std_logic_vector(31 downto 0) := x"00000000");
 PORT
 (
  clk :  IN  STD_LOGIC;
  clr :  IN  STD_LOGIC;
  LO_in :  IN  STD_LOGIC;
  BusMuxOut :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
  BusMuxIn_LO :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0) := VAL
 );
END component LO;


component Z is
generic (VAL : std_logic_vector(31 downto 0) := x"00000000");
 port(
  Z_in : IN STD_LOGIC; -- load/enable.
  clr : IN STD_LOGIC; -- async. clear.
  clk : IN STD_LOGIC; -- clock.
  Zin_hi : in std_logic_vector(31 downto 0); 
  Zin_low : in std_logic_vector(31 downto 0); 
  BusMuxin1 : out std_logic_vector(31 downto 0); --32bit output
  BusMuxin0 : out std_logic_vector(31 downto 0) --32bit output
 );
end component Z;


component Y_reg is
generic (VAL : std_logic_vector(31 downto 0) := x"00000000");
PORT(
BusMuxOut : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- input.
Y_in : IN STD_LOGIC; -- load/enable.
clr : IN STD_LOGIC; -- async. clear.
clk : IN STD_LOGIC; -- clock.
Alu_in : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) := VAL -- output.
);
end component Y_reg;


component PC is
generic(VAL : std_logic_vector(31 downto 0) := x"00000000");
PORT(
BusMuxOut : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- input.
PC_in : IN STD_LOGIC; -- load/enable.
IncPC : IN STD_LOGIC; 
clr : IN STD_LOGIC; -- async. clear.
clk : IN STD_LOGIC; -- clock.
BusMuxIn_PC : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) := VAL-- output.	
);
end component PC;


component IR is
generic (VAL : std_logic_vector(31 downto 0) := x"00000000");
PORT(
IR_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- input.
IR_en : IN STD_LOGIC; -- load/enable.
clr : IN STD_LOGIC; -- async. clear.
clk : IN STD_LOGIC; -- clock.
IR_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) := VAL-- output.
);
end component IR;

component RAM IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (8 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END component RAM;

component selEncode IS
	PORT(
		  Gra: IN STD_LOGIC;
		  Grb: IN STD_LOGIC;
		  Grc: IN STD_LOGIC;
		  Rin: IN STD_LOGIC;
		  Rout: IN STD_LOGIC;
		  BAout: IN STD_LOGIC;
		  IRout: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		  R0in: OUT STD_LOGIC := '0';
        R1in: OUT STD_LOGIC := '0';
        R2in: OUT STD_LOGIC := '0';
		  R3in: OUT STD_LOGIC := '0';
		  R4in: OUT STD_LOGIC := '0';
		  R5in: OUT STD_LOGIC := '0';
		  R6in: OUT STD_LOGIC := '0';
		  R7in: OUT STD_LOGIC := '0';
		  R8in: OUT STD_LOGIC := '0';
		  R9in: OUT STD_LOGIC := '0';
		  R10in: OUT STD_LOGIC := '0';
		  R11in: OUT STD_LOGIC := '0';
		  R12in: OUT STD_LOGIC := '0';
		  R13in: OUT STD_LOGIC := '0';
		  R14in: OUT STD_LOGIC := '0';
		  R15in: OUT STD_LOGIC := '0';
		  R0out: OUT STD_LOGIC := '0';
		  R1out: OUT STD_LOGIC := '0';
		  R2out: OUT STD_LOGIC := '0';
		  R3out: OUT STD_LOGIC := '0';
		  R4out: OUT STD_LOGIC := '0';
		  R5out: OUT STD_LOGIC := '0';
		  R6out: OUT STD_LOGIC := '0';
		  R7out: OUT STD_LOGIC := '0';
		  R8out: OUT STD_LOGIC := '0';
		  R9out: OUT STD_LOGIC := '0';
		  R10out: OUT STD_LOGIC := '0';
		  R11out: OUT STD_LOGIC := '0';
		  R12out: OUT STD_LOGIC := '0';
		  R13out: OUT STD_LOGIC := '0';
		  R14out: OUT STD_LOGIC := '0';
		  R15out: OUT STD_LOGIC := '0';
		  C_sign_extended: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)	
);
END component selEncode;


component R0 IS
generic (VAL : std_logic_vector(31 downto 0) := x"00000000");
	PORT(
		clk: IN STD_LOGIC;
		clr: IN STD_LOGIC;
		R0in: IN STD_LOGIC;
		BusMuxOut: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		BAout: IN STD_LOGIC;
		BusMuxIn_R0: OUT STD_LOGIC_VECTOR(31 DOWNTO 0) := VAL
);
END component R0;


component CONFF 
port(
   BusMuxOut : in std_logic_vector(31 downto 0);
   clr : in std_logic;
   clk : in std_logic;
   CONin : in std_logic; --load/enable
   IRout : in std_logic_vector(31 downto 0);
   CONFFout : out std_logic
);
end component CONFF;

component InPort is
generic (VAL : std_logic_vector(31 downto 0) := x"00000000");
port(
InputUnit : in std_logic_vector(31 downto 0);
clr : in std_logic;
clk : in std_logic;
InPortin : in std_logic;
BusMuxIn_IN_PORT : out std_logic_vector(31 downto 0) := VAL
);
end component InPort;

component OutPort is
generic (VAL : std_logic_vector(31 downto 0) := x"00000000");
port(
clr : in std_logic;
clk : in std_logic;
OutPortin : in std_logic;
BusMuxOut : in std_logic_vector(31 downto 0);
OutputUnit : out std_logic_vector(31 downto 0) := VAL
);
end component OutPort;


COMPONENT control_unit IS
PORT(
Clock, Reset, Stop, CON_FF : IN STD_LOGIC;  
IR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

Write_i : OUT  STD_LOGIC;
Read : OUT  STD_LOGIC;
InPortout : OUT  STD_LOGIC;

clr : OUT  STD_LOGIC;
Run : OUT  STD_LOGIC;
		
HIin : OUT  STD_LOGIC;
LOin : OUT  STD_LOGIC;
CONin : OUT  STD_LOGIC;
PCin : OUT  STD_LOGIC;
IRin :  OUT  STD_LOGIC;
Yin : OUT  STD_LOGIC;
Zin : OUT  STD_LOGIC;
MDRin : OUT  STD_LOGIC;
MARin : OUT  STD_LOGIC;
OutPortin : OUT  STD_LOGIC;
Cout : OUT  STD_LOGIC;
BAout : OUT  STD_LOGIC;

ADD_i : OUT STD_LOGIC;
SUB_i : OUT STD_LOGIC;
MUL_i : OUT STD_LOGIC;
DIV_i : OUT STD_LOGIC;
SHR_i : OUT STD_LOGIC;
SHL_i : OUT STD_LOGIC;
ROR_i : OUT STD_LOGIC;
ROL_i : OUT STD_LOGIC;
AND_i : OUT STD_LOGIC;
OR_i : OUT STD_LOGIC;
NEG_i : OUT STD_LOGIC;
NOT_i : OUT STD_LOGIC;

PCout : OUT  STD_LOGIC;
MDRout : OUT  STD_LOGIC;
Zhighout : OUT  STD_LOGIC;
Zlowout : OUT  STD_LOGIC;
HIout : OUT  STD_LOGIC;
LOout : OUT  STD_LOGIC;

Gra : OUT  STD_LOGIC;
Grb : OUT STD_LOGIC;
Grc : OUT  STD_LOGIC;
Rin : OUT  STD_LOGIC;
Rout : OUT  STD_LOGIC;

	
IncPC : OUT  STD_LOGIC;
InPortin : OUT  STD_LOGIC;
--CONout : OUT  STD_LOGIC;

R14in_enable : OUT STD_LOGIC

--InputUnit : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
--BusMuxOut1 : OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
--OutputUnit : OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
);
END COMPONENT control_unit;


signal R0in : STD_LOGIC; 
signal R1in : STD_LOGIC;
signal R2in : STD_LOGIC;
signal R3in : STD_LOGIC;
signal R4in : STD_LOGIC;
signal R5in : STD_LOGIC;
signal R6in : STD_LOGIC;
signal R7in : STD_LOGIC;
signal R8in : STD_LOGIC;
signal R9in : STD_LOGIC;
signal R10in : STD_LOGIC;
signal R11in : STD_LOGIC;
signal R12in : STD_LOGIC;
signal R13in : STD_LOGIC;
signal R14in : STD_LOGIC;
signal R15in : STD_LOGIC;
signal R0out : STD_LOGIC; -- load/enable.
signal R1out : STD_LOGIC;
signal R2out : STD_LOGIC;
signal R3out : STD_LOGIC;
signal R4out : STD_LOGIC;
signal R5out : STD_LOGIC;
signal R6out : STD_LOGIC;
signal R7out : STD_LOGIC;
signal R8out : STD_LOGIC;
signal R9out : STD_LOGIC;
signal R10out : STD_LOGIC;
signal R11out : STD_LOGIC;
signal R12out : STD_LOGIC;
signal R13out : STD_LOGIC;
signal R14out : STD_LOGIC;
signal R15out : STD_LOGIC;

signal BusMuxIn_PC : std_logic_vector(31 downto 0);
signal BusMuxIn_MDR : std_logic_vector(31 downto 0);
signal MARout : std_logic_vector(31 downto 0);
signal Mdatain : STD_LOGIC_VECTOR(31 DOWNTO 0);

signal BusMuxIn_R0,BusMuxIn_R1,BusMuxIn_R2,BusMuxIn_R3,BusMuxIn_R4,BusMuxIn_R5,
BusMuxIn_R6,BusMuxIn_R7,BusMuxIn_R8,BusMuxIn_R9,BusMuxIn_R10,BusMuxIn_R11,
BusMuxIn_R12,BusMuxIn_R13,BusMuxIn_R14,BusMuxIn_R15,
BusMuxIn_Zhigh: std_logic_vector(31 downto 0);
signal BusMuxIn_Zlow : std_logic_vector(31 downto 0);
signal BusMuxIn_HI,BusMuxIn_LO : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal BusMuxIn_IN_PORT,C_sign_extended : std_logic_vector(31 downto 0);
signal Yout : std_logic_vector(31 downto 0);
signal BusMuxOut2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal ALU_Select : STD_LOGIC_VECTOR(3 downto 0);
signal ALU_C_HI : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal ALU_C_LO : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal ALU_OUT : STD_LOGIC_VECTOR(63 downto 0);

signal BusmuxSin : STD_LOGIC_VECTOR(4 DOWNTO 0);
begin

BusMuxOut1 <= BusMuxOut2;

regR1: register32
generic map(VAL => x"00000000")
PORT MAP(
BusMuxOut => BusMuxOut2,
reg32_in => R1in,
clr => clear,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R1
);


regR2: register32
generic map(VAL => x"00000000")
PORT MAP(
BusMuxOut => BusMuxOut2,
reg32_in => R2in,
clr => clear,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R2
);


regR3: register32
generic map(VAL => x"00000000")
PORT MAP(
BusMuxOut => BusMuxOut2,
reg32_in => R3in,
clr => clear,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R3
);


regR4: register32
generic map(VAL => x"00000000")
PORT MAP(
BusMuxOut => BusMuxOut2,
reg32_in => R4in,
clr => clear,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R4
);


regR5: register32
generic map(VAL => x"00000000")
PORT MAP(
BusMuxOut => BusMuxOut2,
reg32_in => R5in,
clr => clear,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R5
);


regR6: register32
generic map(VAL => x"00000000")
PORT MAP(
BusMuxOut => BusMuxOut2,
reg32_in => R6in,
clr => clear,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R6
);


regR7: register32
generic map(VAL => x"00000000")
PORT MAP(
BusMuxOut => BusMuxOut2,
reg32_in => R7in,
clr => clear,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R7
);


regR8: register32
generic map(VAL => x"00000000")
PORT MAP(
BusMuxOut => BusMuxOut2,
reg32_in => R8in,
clr => clear,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R8
);


regR9: register32
generic map(VAL => x"00000000")
PORT MAP(
BusMuxOut => BusMuxOut2,
reg32_in => R9in,
clr => clear,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R9
);



regR10: register32
generic map(VAL => x"00000000")
PORT MAP(
BusMuxOut => BusMuxOut2,
reg32_in => R10in,
clr => clear,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R10
);


regR11: register32
generic map(VAL => x"00000000")
PORT MAP(
BusMuxOut => BusMuxOut2,
reg32_in => R11in,
clr => clear,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R11
);


regR12: register32
generic map(VAL => x"00000000")
PORT MAP(
BusMuxOut => BusMuxOut2,
reg32_in => R12in,
clr => clear,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R12
);


regR13: register32
generic map(VAL => x"00000000")
PORT MAP(
BusMuxOut => BusMuxOut2,
reg32_in => R13in,
clr => clear,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R13
);


regR14: register32
generic map(VAL => x"00000000")
PORT MAP(
BusMuxOut => BusMuxOut2,
reg32_in => R14in,
clr => clear,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R14
);


regR15: register32
generic map(VAL => x"00000000")
PORT MAP(
BusMuxOut => BusMuxOut2,
reg32_in => R15in,
clr => clear,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R15
);


regHI: HI  
generic map(VAL => x"00000000")
 PORT MAP
 (
  clk => Clock,
  clr => clear,
  HI_in => HIin,
  BusMuxOut => BusMuxOut2,
  BusMuxIn_HI => BusMuxIn_HI
 );


regLOW: LO
generic map(VAL => x"00000000")
 PORT MAP
 (
  clk => Clock,
  clr => clear,
  LO_in => LOin,
  BusMuxOut => BusMuxOut2,
  BusMuxIn_LO => BusMuxIn_LO
 );

regY: Y_reg
generic map(VAL => x"00000000")
PORT MAP(
BusMuxOut => BusMuxOut2,
Y_in => Yin,
clr => clear,
clk => Clock,
Alu_in => Yout
);
 
ALU_ENCODER1 : ALU_encoder
 PORT MAP(
 		AND_i => AND_i,
		OR_i => OR_i,
		NOT_i => NOT_i,
		NEG_i => NEG_i,
		ADD_i => ADD_i,
		SUB_i => SUB_i,
		MUL_i => MUL_i,
		DIV_i => DIV_i,
		SHR_i => SHR_i,
		SHL_i => SHL_i,
		ROR_i => ROR_i,
		ROL_i => ROL_i,
		ALU_SEL => ALU_Select
 );  


ALURes: ALU
PORT MAP (
A => Yout,
B => BusMuxOut2,
ALU_sel => ALU_Select,
C_HI => ALU_C_HI,
C_LO => ALU_C_LO
);


regZ: Z
generic map(VAL => x"00000000")
 PORT MAP(  
  Z_in => Zin,
  clr => clear,
  clk => Clock,
  Zin_hi => ALU_C_HI,
  Zin_low => ALU_C_LO,
  BusMuxin1 => BusMuxIn_Zhigh,
  BusMuxin0 => BusMuxIn_Zlow
 );


refMDR: MDR 
generic map(VAL => x"00000000")
PORT MAP( 
	 busMuxOut => BusMuxOut2,
    Mdatain => Mdatain,
    clr => clear,
    clk => Clock,
    MDRin => MDRin,
    Read_s => Read,
    BusMuxIn_MDR => BusMuxIn_MDR
);

regPC: PC
generic map(VAL => x"00000000")
PORT MAP(
BusMuxOut => BusMuxOut2,
PC_in => PCin,
IncPC => IncPC,
clr => clear,
clk => Clock,
BusMuxIn_PC => BusMuxIn_PC
);

regIR : IR 
generic map(VAL => x"00000000")
PORT MAP(
IR_in => BusMuxOut2,
IR_en => IRin,
clr => clear,
clk => Clock,
IR_out => IRout 
);

regMAR: MAR 
generic map(VAL => x"00000000")
PORT MAP(
MAR_in => BusMuxOut2,
MAR_en => MARin,
clr => clear,
clk => Clock,
MAR_out => MARout 
);

Busmux_encoder: encoder
PORT MAP( 
R0out => R0out,
R1out => R1out,
R2out => R2out,
R3out => R3out,
R4out => R4out,
R5out => R5out,
R6out => R6out,
R7out => R7out,
R8out => R8out,
R9out => R9out,
R10out => R10out,
R11out => R11out,
R12out => R12out,
R13out => R13out,
R14out => R14out,
R15out => R15out,
HIout => HIout,
LOout => LOout,
Zhighout => Zhighout,
Zlowout => Zlowout,
PCout => PCout,
MDRout => MDRout,
InPortout => InPortout,
Cout => Cout,
o => BusmuxSin
);  


BusMux1: busmux 
PORT MAP(
BusMuxIn_R0 => BusMuxIn_R0,
BusMuxIn_R1 => BusMuxIn_R1,
BusMuxIn_R2 => BusMuxIn_R2,
BusMuxIn_R3 => BusMuxIn_R3,
BusMuxIn_R4 => BusMuxIn_R4,
BusMuxIn_R5 => BusMuxIn_R5,
BusMuxIn_R6 => BusMuxIn_R6,
BusMuxIn_R7 => BusMuxIn_R7,
BusMuxIn_R8 => BusMuxIn_R8,
BusMuxIn_R9 => BusMuxIn_R9,
BusMuxIn_R10 => BusMuxIn_R10,
BusMuxIn_R11 => BusMuxIn_R11,
BusMuxIn_R12 => BusMuxIn_R12,
BusMuxIn_R13 => BusMuxIn_R13,
BusMuxIn_R14 => BusMuxIn_R14,
BusMuxIn_R15 => BusMuxIn_R15,
BusMuxIn_HI => BusMuxIn_HI,
BusMuxIn_LO => BusMuxIn_LO,
BusMuxIn_Zhigh => BusMuxIn_Zhigh,
BusMuxIn_Zlow => BusMuxIn_Zlow,
BusMuxIn_PC => BusMuxIn_PC,
BusMuxIn_MDR => BusMuxIn_MDR,
BusMuxIn_IN_PORT => BusMuxIn_IN_PORT,
C_sign_extended => C_sign_extended,
Sin => BusmuxSin,
BusMuxOut => BusMuxOut2
);


RAM_32_1 : RAM PORT MAP (
		address	 => MARout(8 DOWNTO 0),
		clock	 => Clock,
		data	 => BusMuxIn_MDR,
		wren	 => Write_i,
		q	 => Mdatain
);

selEncode1 : selEncode
	PORT MAP(
		Gra => Gra,
		Grb => Grb,
		Grc => Grc,
		Rin => Rin,
		Rout => Rout,
		BAout => BAout,
		IRout => IRout,
		R0in => R0in,
		R1in => R1in,
		R2in => R2in,
		R3in => R3in,
		R4in => R4in,
		R5in => R5in,
		R6in => R6in,
		R7in => R7in,
		R8in => R8in,
		R9in => R9in,
		R10in => R10in,
		R11in => R11in,
		R12in => R12in,
		R13in => R13in,
		R14in => R14in,
		R15in => R15in,
		R0out => R0out,
		R1out => R1out,
		R2out => R2out,
		R3out => R3out,
		R4out => R4out,
		R5out => R5out,
		R6out => R6out,
		R7out => R7out,
		R8out => R8out,
		R9out => R9out,
		R10out => R10out,
		R11out => R11out,
		R12out => R12out,
		R13out => R13out,
		R14out => R14out,
		R15out => R15out,
		C_sign_extended => C_sign_extended	
);

regR0: R0
generic map(VAL => x"00000000")
PORT MAP(
		clk => Clock,
		clr => clear,
		R0in => R0in,
		BusMuxOut => BusMuxOut2,
		BAout => BAout,
		BusMuxIn_R0 => BusMuxIn_R0
);

CONFF1: CONFF 
port map(
   BusMuxOut => BusMuxOut2,
   clr => clear,
   clk => Clock,
   CONin => CONin,
   IRout => IRout,
   CONFFout => CON_FF
);


regInPort1 : InPort 
generic map(VAL => x"00000000")
port map(
InputUnit => InputUnit,
clr => clear,
clk => Clock,
InPortin => InPortin,
BusMuxIn_IN_PORT => BusMuxIn_IN_PORT
);


regOutPort1 : OutPort
generic map(VAL => x"00000000")
port map(
clr => clear,
clk => Clock,
OutPortin => OutPortin,
BusMuxOut => BusMuxOut2,
OutputUnit => OutputUnit
);


CONTROLUNIT1 : control_unit
PORT MAP(
Clock => Clock,
Reset => Reset,
Stop => Stop,
CON_FF => CON_FF,
IR => IRout,

Write_i => Write_i,
Read => Read,
InPortout => InPortout,
clr => clear,
Run => Run,

HIin => HIin,
LOin => LOin,
CONin => CONin,
PCin => PCin,
IRin => IRin,
Yin => Yin,
Zin => Zin,
MDRin => MDRin,
MARin => MARin,
OutPortin => OutPortin,
Cout => Cout,
BAout => BAout,	

AND_i => AND_i,
OR_i => OR_i,
NOT_i => NOT_i,
NEG_i => NEG_i,
ADD_i => ADD_i,
SUB_i => SUB_i,
MUL_i => MUL_i,
DIV_i => DIV_i,
SHR_i => SHR_i,
SHL_i => SHL_i,
ROR_i => ROR_i,
ROL_i => ROL_i,


PCout => PCout,
MDRout => MDRout,
Zhighout => Zhighout,
Zlowout => Zlowout,
HIout => HIout,
LOout => LOout,

Gra => Gra,
Grb => Grb,
Grc => Grc,
Rin => Rin,
Rout => Rout,

IncPC => IncPC,
InPortin => InPortin,
R14in_enable => R14in_enable
);

end behavior;








