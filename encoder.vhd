library ieee;
use ieee.std_logic_1164.all;

entity encoder is
 port( 

 R0out,R1out,R2out,R3out,R4out,R5out,R6out,R7out,R8out,R9out,
R10out,R11out,R12out,R13out,R14out,R15out,HIout,LOout,Zhighout,Zlowout,
PCout,MDRout,InPortout,Cout: in std_logic;
o : out std_logic_vector(4 downto 0) 
 );  
end entity;

ARCHITECTURE behavior of encoder is
BEGIN
Busmux_encoder : process(R0out,R1out,R2out,R3out,R4out,R5out,R6out,R7out,R8out,R9out,
R10out,R11out,R12out,R13out,R14out,R15out,HIout,LOout,Zhighout,Zlowout,
PCout,MDRout,InPortout,Cout)
variable tempI : std_logic_vector(31 downto 0);
begin

 tempI(0):= R0out; tempI(1):= R1out; tempI(2):= R2out;
 tempI(3):= R3out; tempI(4):= R4out; tempI(5):= R5out; tempI(6):= R6out; tempI(7):= R7out; tempI(8):= R8out;
 tempI(9):= R9out; tempI(10):= R10out; tempI(11):= R11out; tempI(12):= R12out; tempI(13):= R13out; tempI(14):= R14out; tempI(15):= R15out;
 tempI(16):= HIout; tempI(17):= LOout; tempI(18):= Zhighout; tempI(19):= Zlowout; tempI(20):= PCout;  
 tempI(21):= MDRout; tempI(22):= InPortout; tempI(23):= Cout;  tempI(31 downto 24) := "00000000";
 
 case(tempI) is
  when x"00000001" => o <= "00000";
  when x"00000002" => o <= "00001";
  when x"00000004" => o <= "00010";
  when x"00000008" => o <= "00011";
  when x"00000010" => o <= "00100";
  when x"00000020" => o <= "00101";
  when x"00000040" => o <= "00110";
  when x"00000080" => o <= "00111";
  when x"00000100" => o <= "01000";
  when x"00000200" => o <= "01001";
  when x"00000400" => o <= "01010";
  when x"00000800" => o <= "01011";
  when x"00001000" => o <= "01100";
  when x"00002000" => o <= "01101";
  when x"00004000" => o <= "01110";
  when x"00008000" => o <= "01111";
  when x"00010000" => o <= "10000";
  when x"00020000" => o <= "10001";
  when x"00040000" => o <= "10010";
  when x"00080000" => o <= "10011";
  when x"00100000" => o <= "10100";
  when x"00200000" => o <= "10101";
  when x"00400000" => o <= "10110";
  when x"00800000" => o <= "10111";
  when x"01000000" => o <= "11000";
  when x"02000000" => o <= "11001";
  when x"04000000" => o <= "11010";
  when x"08000000" => o <= "11011";
  when x"10000000" => o <= "11100";
  when x"20000000" => o <= "11101";
  when x"40000000" => o <= "11110";
  when x"80000000" => o <= "11111";
  when others 		 => o <= "00000";
 end case;
 end process;
 end architecture;







