LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MDR IS
PORT(
    busMuxOut: IN std_logic_vector(31 downto 0);
    Mdatain:    IN std_logic_vector(31 downto 0);
    clr:        IN std_logic;
    clk:        IN std_logic;
    MDRin:      IN std_logic;
    Read_s:     IN std_logic;
    MDRoutput: OUT std_logic_vector(31 downto 0)
);
END MDR;

ARCHITECTURE behaviour OF MDR IS 
 BEGIN
 PROCESS(clr, clk, busMuxOut, MDatain, Read_s, MDRin)
 BEGIN
 IF clr ='0' THEN
        MDRoutput <= (others =>'0');
 ELSIF rising_edge(clk) THEN
   IF MDRin = '1' THEN
    IF (Read_s = '0') THEN
       MDRoutput <= busMuxOut;
    ELSE
       MDRoutput <= MdataIn;
    END IF;
   END IF;
 END IF;
 END PROCESS;
END;