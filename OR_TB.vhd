LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY or_tb IS
END ENTITY or_tb;

-- Architecture of the testbench with the signal names
ARCHITECTURE or_tb_arch OF or_tb IS -- Add any other signals to see in your simulation

SIGNAL PCout_tb, Zlowout_tb, MDRout_tb, R2out_tb, R4out_tb: std_logic;
SIGNAL MARin_tb, Zin_tb, PCin_tb, MDRin_tb, IRin_tb, Yin_tb: std_logic;
SIGNAL IncPC_tb, Read_tb, OR_tb, R5in_tb, R2in_tb, R4in_tb: std_logic;
SIGNAL Clock_tb, BusMuxOut_tb: std_logic;
--SIGNAL Clear_tb: std_logic;
SIGNAL Mdatain_tb : std_logic_vector (31 downto 0);

TYPE State IS (default, Reg_load1a, Reg_load1b, Reg_load2a, Reg_load2b, Reg_load3a, Reg_load3b, T0, T1,
T2, T3, T4, T5);

SIGNAL Present_state: State := default;
COMPONENT datapath
	 PORT (
  R2out :  IN  STD_LOGIC;
  MDRout :  IN  STD_LOGIC;
  PCout :  IN  STD_LOGIC;
  Zlowout :  IN  STD_LOGIC;
  R4out :  IN  STD_LOGIC;
  MARin :  IN  STD_LOGIC;
  PCin :  IN  STD_LOGIC;
  Zin :  IN  STD_LOGIC;
  MDRin :  IN  STD_LOGIC;
  IRin :  IN  STD_LOGIC;
  Yin :  IN  STD_LOGIC; 
  IncPC :  IN  STD_LOGIC;
  Read :  IN  STD_LOGIC;
  OR_i :  IN  STD_LOGIC;
  R5in :  IN  STD_LOGIC;
  R2in :  IN  STD_LOGIC;
  R4in :  IN  STD_LOGIC;
  Clock :  IN  STD_LOGIC;
	 BusMuxOut1 : OUT STD_LOGIC_VECTOR(31 downto 0);
  Mdatain :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
 END COMPONENT datapath;


BEGIN

DUT : datapath
	--port mapping: between the dut and the testbench signals
	PORT MAP (
  Clock => Clock_tb,
  R2out => R2out_tb,
  R4out => R4out_tb,
  Zlowout => Zlowout_tb,
  MDRout => MDRout_tb,
  PCout => PCout_tb,
  R2in => R2in_tb,
  R4in => R4in_tb,
  R5in => R5in_tb,
  Read => Read_tb,
  MDRin => MDRin_tb,
  Yin => Yin_tb,
  PCin => PCin_tb,
  IncPC => IncPC_tb,
  IRin => IRin_tb,
  MARin => MARin_tb,
  OR_i => OR_tb,
  Zin => Zin_tb,
  Mdatain => Mdatain_tb,
  BusMuxOut1 => BusMuxOut_tb

	);
	
	--add test logic here
	Clock_process: PROCESS IS
		BEGIN
			Clock_tb <= '1', '0' after 10 ns;
			wait for 20 ns;
	END PROCESS Clock_process;

	PROCESS (Clock_tb) IS 
		BEGIN
			IF (rising_edge (Clock_tb)) THEN 
				CASE Present_state IS
					WHEN Default =>
						Present_state <= Reg_load1a;
					WHEN Reg_load1a =>
						Present_state <= Reg_load1b;
					WHEN Reg_load1b =>
						Present_state <= Reg_load2a;
					WHEN Reg_load2a =>
						Present_state <= Reg_load2b;
					WHEN Reg_load2b =>
						Present_state <= Reg_load3a;
					WHEN Reg_load3a =>
						Present_state <= Reg_load3b;
					WHEN Reg_load3b =>
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
					WHEN OTHERS =>
				END CASE;
			END IF;
	END PROCESS;

	PROCESS (Present_state) IS 
		BEGIN
			CASE Present_state IS 
				WHEN Default =>
					PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; 
					R2out_tb <= '0'; R4out_tb <= '0'; MARin_tb <= '0';
					PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0'; Zin_tb <= '0';
					IncPC_tb <= '0'; Read_tb <= '0'; OR_tb <= '0';
					R2in_tb <= '0'; R4in_tb <= '0'; R5in_tb <= '0'; Mdatain_tb <= x"00000000"; BusMuxOut_tb <= x"00000000";
					
				WHEN Reg_load1a =>
					Mdatain_tb <= x"00000022";
					Read_tb <= '0','1'after 10ns,'0'after 25ns;
					MDRin_tb <= '0','1'after 10ns,'0'after 25ns; BusMuxOut_tb <= x"00000000";
					
				WHEN Reg_load1b =>
					MDRout_tb <= '1'after 10ns,'0'after 25ns; BusMuxOut_tb <= x"00000022";
					R2in_tb <= '1'after 10ns,'0'after 25ns; -- initialize R2 with the value $22
					
				WHEN Reg_load2a =>
					Mdatain_tb <= x"00000024";
					Read_tb <= '1'after 10ns,'0'after 25ns;
					MDRin_tb <= '1'after 10ns,'0'after 25ns; BusMuxOut_tb <= x"00000000";
					
				WHEN Reg_load2b =>
					MDRout_tb <= '1'after 10ns,'0'after 25ns; BusMuxOut_tb <= x"00000024";
					R4in_tb <= '1'after 10ns,'0'after 25ns; -- initialize R4 with the value $24
					
				WHEN Reg_load3a =>
					Mdatain_tb <= x"00000026"; BusMuxOut_tb <= x"00000000";
					Read_tb <= '1'after 10ns,'0'after 25ns; 
					MDRin_tb <= '1'after 10ns,'0'after 25ns; 
					
				WHEN Reg_load3b =>
					MDRout_tb <= '1'after 10ns,'0'after 25ns; BusMuxOut_tb <= x"00000026";
					R5in_tb <= '1'after 10ns,'0'after 25ns; -- initialize R5 with the value $26
				
                WHEN T0 => 
					PCout_tb <= '1'; MARin_tb <= '1'; BusMuxOut_tb <= x"00000000";
					IncPC_tb <= '1'; Zin_tb <= '1'; 
					
				WHEN T1 =>
					Zlowout_tb <= '1';PCin_tb <= '1';Read_tb <= '1';MDRin_tb <= '1';
					Mdatain_tb <= x"52920000"; BusMuxOut_tb <= x"00000000";
					
				WHEN T2 =>
					MDRout_tb <= '1'; IRin_tb <= '1'; BusMuxOut_tb <= x"52920000";
					
				WHEN T3 =>
					R2out_tb <= '1'; Yin_tb <= '1'; BusMuxOut_tb <= x"00000022";
					
				WHEN T4 =>
					R4out_tb <= '1'; OR_tb <= '1'; Zin_tb <= '1';BusMuxOut_tb <= x"00000024";
					
				WHEN T5 =>
					Zlowout_tb <= '1'; R5in_tb <= '1'; BusMuxOut_tb <= x"00000026";
				WHEN OTHERS =>
			END CASE;
	END PROCESS;
END ARCHITECTURE or_tb_arch;
