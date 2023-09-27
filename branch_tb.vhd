LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY branch_tb IS
END ENTITY branch_tb;

ARCHITECTURE behave OF branch_tb IS

SIGNAL Clock_tb, Clear_tb: std_logic;
SIGNAL PCout_tb, PCin_tb, IncPC_tb, IRin_tb: std_logic;
SIGNAL MARin_tb, Read_tb, MDRin_tb, MDRout_tb,Rin_tb,Rout_tb: std_logic;
SIGNAL Gra_tb, Grb_tb, BAout_tb, Cout_tb: std_logic;
SIGNAL Yin_tb, Zin_tb, ADD_tb, Zlowout_tb: std_logic;
SIGNAL CONin_tb,CONout_tb: STD_LOGIC; 
SIGNAL BusMuxOut1_tb : std_logic_vector (31 downto 0);


TYPE STATE IS (default, T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15);

SIGNAL Present_state: State:= default;

COMPONENT datapath2

PORT(
clr : IN STD_LOGIC; -- async. clear.
Clock : IN STD_LOGIC; -- clock.
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
HIout : IN STD_LOGIC;
LOout : IN STD_LOGIC;
Zhighout : IN STD_LOGIC;
Zlowout : IN STD_LOGIC;
PCout : IN STD_LOGIC;
MDRout : IN STD_LOGIC;
InPortout : IN STD_LOGIC;
Cout : IN STD_LOGIC;
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

BusMuxOut1 : OUT std_logic_vector(31 downto 0);

Write_i : IN STD_LOGIC;
OutPortin : IN STD_LOGIC;
Gra: IN STD_LOGIC;
Grb: IN STD_LOGIC;
Grc: IN STD_LOGIC;
Rin: IN STD_LOGIC;
Rout: IN STD_LOGIC;
BAout: IN STD_LOGIC;
CONin : in std_logic; --load/enable
CONFFout : out std_logic;
InputUnit : in std_logic_vector(31 downto 0);
OutputUnit : out std_logic_vector(31 downto 0)   
        );
    END COMPONENT datapath2;
BEGIN

DUT : datapath2

    PORT MAP (
	   clr => Clear_tb,
		Clock => Clock_tb,
		HIin => '0',
		LOin => '0',
		PCin => PCin_tb,
		IRin => IRin_tb,
		Zin => Zin_tb,
		Yin => Yin_tb,
		MARin => MARin_tb,
		MDRin => MDRin_tb,
		InPortin => '0',
		Read => Read_tb,	
		IncPC => IncPC_tb,
		HIout => '0',
		LOout => '0',
		Zhighout => '0',
		Zlowout => Zlowout_tb,	
		PCout => PCout_tb,
		MDRout => MDRout_tb,
		InPortout => '0',
		Cout => Cout_tb,
		
		ADD_i => ADD_tb,
		SUB_i => '0',
		MUL_i => '0',
		DIV_i => '0',
		SHR_i => '0',
		SHL_i => '0',
		ROR_i => '0',
		ROL_i => '0',
		AND_i => '0',
		OR_i => '0',	
		NEG_i => '0',
		NOT_i => '0',	
		
		BusMuxOut1 => BusMuxOut1_tb,		
		Write_i => '0',
		OutPortin => '0',
		Gra => Gra_tb,
		Grb => Grb_tb,	
		Grc => '0',
		Rin => Rin_tb,
		Rout => Rout_tb,
		BAout => BAout_tb,
		CONin => CONin_tb,
		CONFFout => CONout_tb,
		InputUnit => x"00000000"	
    );

    Clock_process: PROCESS IS
        BEGIN 
            Clock_tb <= '1', '0' after 10 ns;
            wait for 20 ns;
    END PROCESS Clock_process;


    PROCESS(Clock_tb) IS
        BEGIN 
            IF (rising_edge(Clock_tb))THEN
                CASE Present_state IS   
                    WHEN default =>
                        Present_state <= T0;
                    WHEN T0 =>
                        Present_state <= T1;
                    WHEN T1 =>
                        Present_state <= T2;
                    WHEN T2 =>
                        Present_state <= T3;
                    WHEN T3 =>
                        Present_state <= T4;
                    WHEN T4 =>
                        Present_state <= T5;
                    WHEN T5 =>
                        Present_state <= T6;
                    WHEN T6 =>
                        Present_state <= T7;
                    WHEN T7 =>
                        Present_state <= T8;
                    WHEN T8 =>
                        Present_state <= T9;
                    WHEN T9 =>
                        Present_state <= T10;
                    WHEN T10 =>
                        Present_state <= T11;
                    WHEN T11 =>
                        Present_state <= T12;
                    WHEN T12 =>
                        Present_state <= T13;
                    WHEN T13 =>
                        Present_state <= T14;
                    WHEN T14 =>
                        Present_state <= T15;
                    WHEN OTHERS =>
                END CASE;
            END IF;
        END PROCESS;

        PROCESS(Present_state) IS
            BEGIN 
                CASE Present_state IS
                    WHEN default=>
                    Clear_tb <= '0';PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; 
					     Cout_tb <= '0'; CONin_tb <= '0'; CONout_tb <= '0';
					     BAout_tb <= '0';  IncPC_tb <= '0'; Zin_tb <= '0'; Rout_tb <= '0';
					     Gra_tb <= '0'; Grb_tb <= '0';   ADD_tb <= '0'; PCin_tb <='0'; 
					     MARin_tb <= '0'; Read_tb <= '0'; MDRin_tb <= '0'; 
					     IRin_tb <= '0'; Yin_tb <= '0'; Rin_tb <= '0';
                    
                    WHEN T0 =>
					         PCout_tb <= '1'; Read_tb <= '1'; MARin_tb <= '1';  
						 
                    WHEN T1 =>
                        PCout_tb <= '0'; MARin_tb <= '0';
					         PCin_tb <= '1';IncPC_tb <= '1';  MDRin_tb <= '1';
                    
						  WHEN T2 =>
                         PCin_tb <= '0';IncPC_tb <= '0';  MDRin_tb <= '0'; Read_tb <= '0';
					          MDRout_tb <= '1'; IRin_tb <= '1';
                    
						  WHEN T3 =>
                        MDRout_tb <= '0'; IRin_tb <= '0';
					         Gra_tb <= '1'; Rout_tb <= '1';CONin_tb <= '1';
								
                    WHEN T4 =>
                        Gra_tb <= '0'; Rout_tb <= '0'; CONin_tb <= '0';
					         PCout_tb <= '1'; Yin_tb <= '1';
						 
                    WHEN T5 =>
                        PCout_tb <= '0'; Yin_tb <= '0';
					         Cout_tb <='1'; ADD_tb <='1';Zin_tb<='1';
								
                    WHEN T6 =>
                        Cout_tb <='0'; ADD_tb <='0';Zin_tb<='0';
					         Zlowout_tb <= '1';
                        IF (CONout_tb = '1') THEN
                            PCin_tb <= '1';
								ELSE
								    PCin_tb <= '0';
                        END IF;
                    WHEN OTHERS=>
                END CASE;
            END PROCESS;
        END ARCHITECTURE;