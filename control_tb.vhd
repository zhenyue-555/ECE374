LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use work.typeState.all;
LIBRARY work;

ENTITY control_tb IS
END;

ARCHITECTURE control_tb_arch OF control_tb IS

		SIGNAL clk_tb : STD_LOGIC;	
		SIGNAL Run_tb : STD_LOGIC;
		SIGNAL Reset_tb : STD_LOGIC; 
		SIGNAL Stop_tb : STD_LOGIC;
		
		SIGNAL clear_tb :  STD_LOGIC;
		SIGNAL HIin_tb :  STD_LOGIC;
		SIGNAL LOin_tb :  STD_LOGIC;
		SIGNAL Yin_tb :  STD_LOGIC;
		SIGNAL PCin_tb : STD_LOGIC;
		SIGNAL IncPC_tb :   STD_LOGIC;
		SIGNAL AND_i_tb :   STD_LOGIC;
		SIGNAL OR_i_tb :  STD_LOGIC;
		SIGNAL NOT_i_tb :   STD_LOGIC;
		SIGNAL NEG_i_tb :  STD_LOGIC;
		SIGNAL ADD_i_tb :  STD_LOGIC;
		SIGNAL SUB_i_tb :   STD_LOGIC;
		SIGNAL MUL_i_tb :  STD_LOGIC;
		SIGNAL DIV_i_tb :   STD_LOGIC;
		SIGNAL SHR_i_tb : STD_LOGIC;
		SIGNAL SHL_i_tb : STD_LOGIC;
		SIGNAL ROR_i_tb : STD_LOGIC;
		SIGNAL ROL_i_tb : STD_LOGIC;
		SIGNAL Zin_tb : STD_LOGIC;
		SIGNAL Write_tb : STD_LOGIC;
		SIGNAL Read_tb : STD_LOGIC;
		SIGNAL MDRin_tb : STD_LOGIC;
		SIGNAL MARin_tb : STD_LOGIC;
		SIGNAL OutPortin_tb : STD_LOGIC;
		SIGNAL InPortin_tb :STD_LOGIC;
		SIGNAL PCout_tb : STD_LOGIC;
		SIGNAL HIout_tb : STD_LOGIC;
		SIGNAL LOout_tb : STD_LOGIC;
		SIGNAL Zhighout_tb :  STD_LOGIC;
		SIGNAL Zlowout_tb : STD_LOGIC;
		SIGNAL MDRout_tb : STD_LOGIC;
		SIGNAL Cout_tb : STD_LOGIC;
		SIGNAL InPortout_tb : STD_LOGIC;
		SIGNAL IRin_tb :  STD_LOGIC;
		SIGNAL Grb_tb :  STD_LOGIC;
		SIGNAL Gra_tb :  STD_LOGIC;
		SIGNAL Grc_tb :  STD_LOGIC;
		SIGNAL Rin_tb :  STD_LOGIC;
		SIGNAL Rout_tb :  STD_LOGIC;
		SIGNAL BAout_tb : STD_LOGIC;
		SIGNAL CONin_tb :  STD_LOGIC;
		SIGNAL InputUnit_tb : STD_LOGIC_VECTOR(31 DOWNTO 0);
		SIGNAL BusMuxOut1_tb :  STD_LOGIC_VECTOR(31 DOWNTO 0);
		SIGNAL OutputUnit_tb :  STD_LOGIC_VECTOR(31 DOWNTO 0);
		SIGNAL CON_FF_tb :  STD_LOGIC;
		SIGNAL R14in_enable_tb :  STD_LOGIC;
		SIGNAL IRout_tb :  STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		SIGNAL Statevalue_tb: State;
		
--		TYPE State IS(
--Reset_stateA, 
--Reset_stateB, 
--fetch0, fetch1, fetch2, fetch3,
--ld3, ld4, ld5, ld6,ld6_1, ld6a, ld7,  ld_withreg_3, ld_withreg_4, ld_withreg_5, ld_withreg_6, ld_withreg_7, ld_withreg_6_1, ld_withreg_6_a,
--ldi3, ldi4, ldi5, ldi_withreg_3, ldi_withreg_4, ldi_withreg_5, st3, st4, st5, st6, st7,st_withreg_3, st_withreg_4, st_withreg_5, st_withreg_6, st_withreg_7, 
--add3, add4, add5, sub3, sub4, sub5, shr3, shr4, shr5, shl3, shl4, shl5, ror3, ror4, ror5, rol3, rol4, rol5,
--and3, and4, and5, or3, or4, or5, addi3, addi4, addi5, andi3, andi4, andi5, ori3, ori4, ori5, 
--mul3, mul4, mul5, mul6, div3, div4, div5, div6, neg3, neg4, not3, not4,
--brzr3, brzr4, brzr5, brzr6, brnz3, brnz4, brnz5, brnz6, brpl3, brpl4, brpl5, brpl6, brmi3, brmi4, brmi5, brmi6, 
--jr3, jal3, jal4, in3, out3, mfhi3, mflo3, nop3, halt3, halt4);
		
		
COMPONENT datapath2
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
Statevalue : OUT State;
BusMuxOut1 : OUT std_logic_vector(31 downto 0);

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
END COMPONENT datapath2;

BEGIN
DUT:datapath2
PORT MAP(
		Clock => clk_tb,	
		Run => Run_tb,
		Reset => Reset_tb,
		Stop => Stop_tb,
		
		clear => clear_tb,
		HIin => HIin_tb,
		LOin => LOin_tb,
		Yin => Yin_tb,
		PCin => PCin_tb,
		IncPC => IncPC_tb,
		AND_i => AND_i_tb,
		OR_i => OR_i_tb,
		NOT_i => NOT_i_tb,
		NEG_i => NEG_i_tb,
		ADD_i => ADD_i_tb,
		SUB_i => SUB_i_tb,
		MUL_i => MUL_i_tb,
		DIV_i => DIV_i_tb,
		SHR_i => SHR_i_tb,
		SHL_i => SHL_i_tb,
		ROR_i => ROR_i_tb,
		ROL_i => ROL_i_tb,
		Zin => Zin_tb,
		Write_i => Write_tb,
		Read => Read_tb,
		MDRin => MDRin_tb,
		MARin => MARin_tb,
		OutPortin => OutPortin_tb,
		InPortin => InPortin_tb,
		PCout => PCout_tb,
		HIout => HIout_tb,
		LOout => LOout_tb,
		Zhighout => Zhighout_tb,
		Zlowout => Zlowout_tb,
		MDRout => MDRout_tb,
		Cout => Cout_tb,
		InPortout => InPortout_tb,
		IRin => IRin_tb,
		Grb => Grb_tb,
		Gra => Gra_tb,
		Grc => Grc_tb,
		Rin => Rin_tb,
		Rout => Rout_tb,
		BAout => BAout_tb,
		CONin => CONin_tb,
		InputUnit => InputUnit_tb,
		BusMuxOut1 => BusMuxOut1_tb,
		OutputUnit => OutputUnit_tb,
		CON_FF => CON_FF_tb,
		IRout => IRout_tb,
		R14in_enable => R14in_enable_tb,
		Statevalue => Statevalue_tb
);

Clock_process: PROCESS
BEGIN 
	clk_tb <= '1', '0' after 10 ns;
	wait for 20 ns;
END PROCESS Clock_process;

new_process: PROCESS
BEGIN
	Stop_tb <= '0';
	Reset_tb <= '1';
   wait for 15 ns;
   Reset_tb <= '0';
   wait for 7000 ns;
----		wait for 3 ns;
----		Reset_tb <= '1'; Stop_tb <= '1'; CON_FF_tb <= '0'; IRout_tb <= x"00000000";
----		wait until rising_edge(clk_tb);
----		Reset_tb <= '0';
----		wait until rising_edge(clk_tb);
----		stop_tb <= '0';
----		IRout_tb <= x"09800087";
----		wait;
END PROCESS new_process;

END ARCHITECTURE; 
