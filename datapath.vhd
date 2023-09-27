library ieee;
library work;
use ieee.std_logic_1164.all;

entity datapath is
port(

clr : IN STD_LOGIC; -- async. clear.
Clock : IN STD_LOGIC; -- clock.
R0in : IN STD_LOGIC; 
R1in : IN STD_LOGIC;
R2in : IN STD_LOGIC;
R3in : IN STD_LOGIC;
R4in : IN STD_LOGIC;
R5in : IN STD_LOGIC;
R6in : IN STD_LOGIC;
R7in : IN STD_LOGIC;
R8in : IN STD_LOGIC;
R9in : IN STD_LOGIC;
R10in : IN STD_LOGIC;
R11in : IN STD_LOGIC;
R12in : IN STD_LOGIC;
R13in : IN STD_LOGIC;
R14in : IN STD_LOGIC;
R15in : IN STD_LOGIC;
HIin : IN STD_LOGIC;
LOin : IN STD_LOGIC;
PCin : IN STD_LOGIC;
IRin : IN STD_LOGIC;
Zin : IN STD_LOGIC;
Yin : IN STD_LOGIC;
MARin : IN STD_LOGIC;
MDRin : IN STD_LOGIC;
InPortin : IN STD_LOGIC;
Read : IN STD_LOGIC;
IncPC : IN STD_LOGIC;

R0out : IN STD_LOGIC; -- load/enable.
R1out : IN STD_LOGIC;
R2out : IN STD_LOGIC;
R3out : IN STD_LOGIC;
R4out : IN STD_LOGIC;
R5out : IN STD_LOGIC;
R6out : IN STD_LOGIC;
R7out : IN STD_LOGIC;
R8out : IN STD_LOGIC;
R9out : IN STD_LOGIC;
R10out : IN STD_LOGIC;
R11out : IN STD_LOGIC;
R12out : IN STD_LOGIC;
R13out : IN STD_LOGIC;
R14out : IN STD_LOGIC;
R15out : IN STD_LOGIC;
HIout : IN STD_LOGIC;
LOout : IN STD_LOGIC;
Zhighout : IN STD_LOGIC;
Zlowout : IN STD_LOGIC;
PCout : IN STD_LOGIC;
MDRout : IN STD_LOGIC;
InPortout : IN STD_LOGIC;
Cout : IN STD_LOGIC;

--ALU_Select : IN STD_LOGIC_VECTOR(3 downto 0);
Mdatain : IN STD_LOGIC_VECTOR(31 DOWNTO 0);


ADD_i : IN STD_LOGIC;
SUB_i : IN STD_LOGIC;
MUL_i : IN STD_LOGIC;
DIV_i : IN STD_LOGIC;
SHR_i : IN STD_LOGIC;
SHL_i : IN STD_LOGIC;
ROR_i : IN STD_LOGIC;
ROL_i : IN STD_LOGIC;
AND_i : IN STD_LOGIC;
OR_i : IN STD_LOGIC;
NEG_i : IN STD_LOGIC;
NOT_i : IN STD_LOGIC;


BusMuxOut1 : OUT std_logic_vector(31 downto 0)

);
end entity datapath;

architecture behavior of datapath is

component register32 is
PORT(
BusMuxOut : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- input.
reg32_in : IN STD_LOGIC; -- load/enable.
clr : IN STD_LOGIC; -- async. clear.
clk : IN STD_LOGIC; -- clock.
BusMuxIn_reg32 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output.
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
end component;

component ALU is
    Port (
    A, B     : in  STD_LOGIC_VECTOR(31 downto 0);  -- 2 inputs 8-bit
    ALU_Sel  : in  STD_LOGIC_VECTOR(3 downto 0);  -- 1 input 4-bit for selecting function
    ALU_Out   : out  STD_LOGIC_VECTOR(63 downto 0) -- 1 output 64-bit 
    );
end component ALU; 


component MDR is
PORT(
    busMuxOut: IN std_logic_vector(31 downto 0);
    Mdatain:    IN std_logic_vector(31 downto 0);
    clr:        IN std_logic;
    clk:        IN std_logic;
    MDRin:      IN std_logic;
    Read_s:     IN std_logic;
    MDRoutput: OUT std_logic_vector(31 downto 0)
);
END component MDR;


component MAR is
PORT(
MAR_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- input.
MAR_en : IN STD_LOGIC; -- load/enable.
clr : IN STD_LOGIC; -- async. clear.
clk : IN STD_LOGIC; -- clock.
MAR_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output.
);
end component MAR;


component HI is
 PORT
 (
  clk :  IN  STD_LOGIC;
  clr :  IN  STD_LOGIC;
  HI_in :  IN  STD_LOGIC;
  BusMuxOut :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
  BusMuxIn_HI :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
 );
END component HI;


component LO is
 PORT
 (
  clk :  IN  STD_LOGIC;
  clr :  IN  STD_LOGIC;
  LO_in :  IN  STD_LOGIC;
  BusMuxOut :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
  BusMuxIn_LO :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
 );
END component LO;


component Z is
 port(
  Z_in : IN STD_LOGIC; -- load/enable.
  clr : IN STD_LOGIC; -- async. clear.
  clk : IN STD_LOGIC; -- clock.
  BusMuxOut : in std_logic_vector(63 downto 0); --64bit input
  BusMuxin1 : out std_logic_vector(31 downto 0); --32bit output
  BusMuxin0 : out std_logic_vector(31 downto 0)  --32bit output
 );
end component Z;


component Y_reg is
PORT(
BusMuxOut : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- input.
Y_in : IN STD_LOGIC; -- load/enable.
clr : IN STD_LOGIC; -- async. clear.
clk : IN STD_LOGIC; -- clock.
Alu_in : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output.
);
end component Y_reg;


component PC is
PORT(
BusMuxOut : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- input.
PC_in : IN STD_LOGIC; -- load/enable.
IncPC : IN STD_LOGIC; 
clr : IN STD_LOGIC; -- async. clear.
clk : IN STD_LOGIC; -- clock.
BusMuxIn_PC : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output.
);
end component PC;


component IR is
PORT(
IR_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- input.
IR_en : IN STD_LOGIC; -- load/enable.
clr : IN STD_LOGIC; -- async. clear.
clk : IN STD_LOGIC; -- clock.
IR_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output.
);
end component IR;

signal BusMuxIn_R0,BusMuxIn_R1,BusMuxIn_R2,BusMuxIn_R3,BusMuxIn_R4,BusMuxIn_R5,
BusMuxIn_R6,BusMuxIn_R7,BusMuxIn_R8,BusMuxIn_R9,BusMuxIn_R10,BusMuxIn_R11,
BusMuxIn_R12,BusMuxIn_R13,BusMuxIn_R14,BusMuxIn_R15,BusMuxIn_HI,BusMuxIn_LO,
BusMuxIn_Zhigh,BusMuxIn_Zlow,BusMuxIn_PC,BusMuxIn_MDR,BusMuxIn_IN_PORT,C_sign_extended : std_logic_vector(31 downto 0);
signal Yout : std_logic_vector(31 downto 0);
signal BusMuxOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal ALU_OUT : STD_LOGIC_VECTOR(63 downto 0);
signal ALU_CarryOut : STD_LOGIC;
signal ALU_Select : STD_LOGIC_VECTOR(3 downto 0);
signal BusmuxSin : STD_LOGIC_VECTOR(4 downto 0);
signal IRout,MARout : std_logic_vector(31 downto 0);

begin

BusMuxOut1 <= BusMuxOut;

regR0: register32
PORT MAP(
BusMuxOut => BusMuxOut,
reg32_in => R0in,
clr => clr,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R0
);


regR1: register32
PORT MAP(
BusMuxOut => BusMuxOut,
reg32_in => R1in,
clr => clr,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R1
);


regR2: register32
PORT MAP(
BusMuxOut => BusMuxOut,
reg32_in => R2in,
clr => clr,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R2
);


regR3: register32
PORT MAP(
BusMuxOut => BusMuxOut,
reg32_in => R3in,
clr => clr,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R3
);


regR4: register32
PORT MAP(
BusMuxOut => BusMuxOut,
reg32_in => R4in,
clr => clr,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R4
);


regR5: register32
PORT MAP(
BusMuxOut => BusMuxOut,
reg32_in => R5in,
clr => clr,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R5
);


regR6: register32
PORT MAP(
BusMuxOut => BusMuxOut,
reg32_in => R6in,
clr => clr,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R6
);


regR7: register32
PORT MAP(
BusMuxOut => BusMuxOut,
reg32_in => R7in,
clr => clr,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R7
);


regR8: register32
PORT MAP(
BusMuxOut => BusMuxOut,
reg32_in => R8in,
clr => clr,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R8
);


regR9: register32
PORT MAP(
BusMuxOut => BusMuxOut,
reg32_in => R9in,
clr => clr,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R9
);



regR10: register32
PORT MAP(
BusMuxOut => BusMuxOut,
reg32_in => R10in,
clr => clr,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R10
);


regR11: register32
PORT MAP(
BusMuxOut => BusMuxOut,
reg32_in => R11in,
clr => clr,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R11
);


regR12: register32
PORT MAP(
BusMuxOut => BusMuxOut,
reg32_in => R12in,
clr => clr,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R12
);


regR13: register32
PORT MAP(
BusMuxOut => BusMuxOut,
reg32_in => R13in,
clr => clr,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R13
);


regR14: register32
PORT MAP(
BusMuxOut => BusMuxOut,
reg32_in => R14in,
clr => clr,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R14
);


regR15: register32
PORT MAP(
BusMuxOut => BusMuxOut,
reg32_in => R15in,
clr => clr,
clk => Clock,
BusMuxIn_reg32 => BusMuxIn_R15
);



regHI: HI  
 PORT MAP
 (
  clk => Clock,
  clr => clr,
  HI_in => HIin,
  BusMuxOut => BusMuxOut,
  BusMuxIn_HI => BusMuxIn_HI
 );


regLOW: LO
 PORT MAP
 (
  clk => Clock,
  clr => clr,
  LO_in => LOin,
  BusMuxOut => BusMuxOut,
  BusMuxIn_LO => BusMuxIn_LO
 );

regY: Y_reg
PORT MAP(
BusMuxOut => BusMuxOut,
Y_in => Yin,
clr => clr,
clk => Clock,
Alu_in => Yout
);
 
ALU_ENCODER1 : ALU_encoder
 PORT MAP(
 I1 => ADD_i,
 I2 => SUB_i,
 I3 => MUL_i,
 I4 => DIV_i,
 I5 => SHL_i,
 I6 => SHR_i,
 I7 => ROL_i,
 I8 => ROR_i,
 I9 => AND_i,
 I10 => OR_i,
 I11 => NEG_i,
 I12 => NOT_i,
 output => ALU_Select
 );  


ALURes: ALU
PORT MAP (
A => Yout,
B => BusMuxOut,
ALU_Sel => ALU_Select,
ALU_Out => ALU_OUT
);


regZ: Z
 PORT MAP(
  Z_in => Zin,
  clr => clr,
  clk => Clock,
  BusMuxOut => ALU_OUT,
  BusMuxin1 => BusMuxIn_Zhigh,
  BusMuxin0 => BusMuxIn_Zlow
 );


refMDR: MDR 
PORT MAP(
    busMuxOut => BusMuxOut,
    Mdatain => Mdatain,
    clr => clr,
    clk => Clock,
    MDRin => MDRin,
    Read_s => Read,
    MDRoutput => BusMuxIn_MDR
);

regPC: PC
PORT MAP(
BusMuxOut => BusMuxOut,
PC_in => PCin,
IncPC => IncPC,
clr => clr,
clk => Clock,
BusMuxIn_PC => BusMuxIn_PC
);


regIR : IR 
PORT MAP(
IR_in => BusMuxOut,
IR_en => IRin,
clr => clr,
clk => Clock,
IR_out => IRout 
);


regMAR: MAR 
PORT MAP(
MAR_in => BusMuxOut,
MAR_en => MARin,
clr => clr,
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
BusMuxOut => BusMuxOut
); 
end behavior;








