-- NEG datapath_tb.vhd file: <This is the filename>
LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- entity declaration only; no definition here
ENTITY NEG_tb IS
END ENTITY NEG_tb;

-- Architecture of the testbench with the signal names
ARCHITECTURE NEG_tb_arch OF NEG_tb IS -- Add any other signals to see in your simulation

SIGNAL PCout_tb, Zlowout_tb, MDRout_tb, R2out_tb, R4out_tb: std_logic;
SIGNAL MARin_tb, PCin_tb, MDRin_tb, IRin_tb, Yin_tb, Zin_tb: std_logic;
SIGNAL IncPC_tb, Read_tb, NEG_tb, R5in_tb, R2in_tb, R4in_tb: std_logic;
SIGNAL Clock_tb: std_logic;
SIGNAL Mdatain_tb: std_logic_vector (31 downto 0);

TYPE State IS (default, Reg_load1a, Reg_load1b, Reg_load2a, Reg_load2b, Reg_load3a, Reg_load3b, T0, T1,
T2, T3, T4, T5);

SIGNAL Present_state: State := default;
-- component instantiation of the datapath
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
  NEG_i :  IN  STD_LOGIC;
  R5in :  IN  STD_LOGIC;
  R2in :  IN  STD_LOGIC;
  R4in :  IN  STD_LOGIC;
  Clock :  IN  STD_LOGIC;
	 
  Mdatain :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
 END COMPONENT datapath;
BEGIN

DUT : datapath
 --port mapping: between the dut NEG the testbench signals
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
  NEG_i => NEG_tb,
  Zin => Zin_tb,
  Mdatain => Mdatain_tb

 );
 --add test logic here
 Clock_process: PROCESS IS
  BEGIN
   Clock_tb <= '1', '0' after 10 ns;
   wait for 20 ns;
 END PROCESS Clock_process;

 PROCESS (Clock_tb) IS -- finite state machine
  BEGIN
   IF (rising_edge (Clock_tb)) THEN -- if clock rising-edge
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

 PROCESS (Present_state) IS -- do the required job in each state
  BEGIN
   CASE Present_state IS -- assert the required signals in each clock cycle
    WHEN Default =>
     PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
     R2out_tb <= '0'; R4out_tb <= '0'; MARin_tb <= '0';
     PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0'; Zin_tb <= '0';
     IncPC_tb <= '0'; Read_tb <= '0'; NEG_tb <= '0';
     R2in_tb <= '0'; R4in_tb <= '0'; R5in_tb <= '0'; Mdatain_tb <= x"00000000";

    WHEN Reg_load1a =>
     Mdatain_tb <= x"00000022";
     Read_tb <= '0','1' after 10ns, '0' after 25ns; 
	  MDRin_tb <= '0','1' after 10ns, '0' after 25ns; 
	  
    WHEN Reg_load1b =>
     MDRout_tb <= '1' after 10ns, '0' after 25ns; 
	  R2in_tb <= '1' after 10 ns, '0' after 25ns; -- initialize R2 with the value $22
	  
    WHEN Reg_load2a =>
     Mdatain_tb <= x"00000024";
     Read_tb <= '1' after 10ns, '0' after 25ns;  
	  MDRin_tb <= '1' after 10ns, '0' after 25ns; 
	  
    WHEN Reg_load2b =>
     MDRout_tb <= '1' after 10ns, '0' after 25ns; 
	  R4in_tb <= '1' after 10ns, '0' after 25ns;  -- initialize R4 with the value $24
    
	 WHEN Reg_load3a =>
     Mdatain_tb <= x"00000026";
     Read_tb <= '1' after 10ns, '0' after 25ns; 
	  MDRin_tb <= '1' after 10ns, '0' after 25ns; 
	  
    WHEN Reg_load3b =>
     MDRout_tb <= '1' after 10ns, '0' after 25ns; 
	  R5in_tb <= '1' after 10ns, '0' after 25ns;  -- initialize R5 with the value $26
    
	 WHEN T0 => -- see if you need to de-assert these signals
     PCout_tb <= '1'; MARin_tb <= '1';
	  IncPC_tb <= '1'; Zin_tb <= '1';
	  
    WHEN T1 =>
     Zlowout_tb <= '1';
     PCin_tb <= '1';  Read_tb <= '1'; MDRin_tb <= '1';
     Mdatain_tb <= x"81200000"; -- opcode for NEG
	  
    WHEN T2 =>
     MDRout_tb <= '1'; IRin_tb <= '1';
	  
    WHEN T3 =>
     R2out_tb <= '1'; Yin_tb <= '1';
	  
    WHEN T4 =>
     R4out_tb <= '1'; NEG_tb <= '1'; Zin_tb <= '1';
	  
    WHEN T5 =>
     Zlowout_tb <= '1'; R5in_tb <= '1';
    WHEN OTHERS =>
   END CASE;
 END PROCESS;
END ARCHITECTURE NEG_tb_arch;