----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2017 12:39:47 PM
-- Design Name: 
-- Module Name: In_Map - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity In_map is
 Port ( 
      Ra:in std_logic_vector(31 downto 0); 
      Rb:in std_logic_vector(31 downto 0); 
      Rc:in std_logic_vector(31 downto 0); 
      Intr:in std_logic_vector(5 downto 0); 
      Ctrl: in std_logic_vector (2 downto 0);
      
      DSP_A: out std_logic_vector(29 downto 0); 
      DSP_B: out std_logic_vector(17 downto 0); 
      DSP_C: out std_logic_vector(47 downto 0); 
      clk: in std_logic); 
      --rst: in std_logic

end In_map;
 

architecture Behavioral of In_Map is
-- signal Ra_in : std_logic_vector(31 downto 0):= (others=>'0');
-- signal Rb_in :  std_logic_vector(31 downto 0):= (others=>'0');
-- signal Rc_in : std_logic_vector(31 downto 0):= (others=>'0');
----- Padding : if not assigned default bit value is zero----------
  signal DSP_A_out: std_logic_vector(29 downto 0):= (others=>'0'); 
  signal DSP_B_out: std_logic_vector(17 downto 0):= (others=>'0');
  signal DSP_C_out: std_logic_vector(47 downto 0):= (others=>'0');
------------------------------------------------------------------- 
 begin
  DSP_A <= DSP_A_out;
  DSP_B <= DSP_B_out;
  DSP_C <= DSP_C_out;
  
 process (clk)
  begin
  if(rising_edge(Clk)) then
 -----32 bit add/sub -------
 
   if(ctrl="001" ) then
     DSP_A_out (13 downto 0) <= Ra(31 downto 18);
       DSP_A_out (29 downto 14) <= (others=>'0');
     DSP_B_out (17 downto 0) <= Ra(17 downto 0);
     DSP_C_out (31 downto 0) <= Rb(31 downto 0);
        DSP_C_out (47 downto 32) <= (others=>'0');
 ------16 bit mult----------  
   elsif (ctrl="010" ) then
    DSP_A_out (15 downto 0) <= Ra(15 downto 0);
        DSP_A_out (29 downto 16) <= (others=>'0');
    DSP_B_out (15 downto 0) <= Rb(15 downto 0);
        DSP_B_out (17 downto 16) <= (others=>'0');
   -- DSP_C_out (31 downto 0) <= Rc(31 downto 0);
        DSP_C_out (47 downto 0) <= (others=>'0');
 ------16 bit mult_and 32 bit_add----------    
   elsif (ctrl="011" ) then
     DSP_A_out (15 downto 0) <= Ra(15 downto 0);
         DSP_A_out (29 downto 16) <= (others=>'0');
     DSP_B_out (15 downto 0) <= Rb(15 downto 0);
         DSP_B_out (17 downto 16) <= (others=>'0');
     DSP_C_out (31 downto 0) <= Rc(31 downto 0);
         DSP_C_out (47 downto 32) <= (others=>'0');
 ----------ld -----------------------
    elsif (ctrl="100") then
      DSP_A_out (15 downto 0) <= Rb(15 downto 0);
          DSP_A_out (29 downto 16) <= (others=>'0');
      DSP_B_out (5 downto 0) <= Intr(5 downto 0);
          DSP_B_out (17 downto 16) <= (others=>'0');
     -- DSP_C_out (31 downto 0) <= Ra(31 downto 0);
          DSP_C_out (47 downto 0) <= (others=>'0'); 
 ----------sw -----------------------
    elsif (ctrl="101") then
      DSP_A_out (15 downto 0) <= Rb(15 downto 0);
          DSP_A_out (29 downto 16) <= (others=>'0');
      DSP_B_out (5 downto 0) <= Intr(5 downto 0);
          DSP_B_out (17 downto 16) <= (others=>'0');
      DSP_C_out (31 downto 0) <= Ra(31 downto 0);
          DSP_C_out (47 downto 32) <= (others=>'0');   
----------- when no command is coming(do nothing?)--------------------       
       else
--    -- DSP_A_out (15 downto 0) <= Rb(15 downto 0);
--         DSP_A_out (29 downto 0) <= (others=>'0');
--    -- DSP_B_out (15 downto 0) <= Intr(15 downto 0);
--         DSP_B_out (17 downto 0) <= (others=>'0');
--    -- DSP_C_out (31 downto 0) <= Ra(31 downto 0);
--         DSP_C_out (47 downto 0) <= (others=>'0');       
       DSP_A_OUT <= DSP_A_OUT;
       DSP_B_OUT <= DSP_B_OUT;
       DSP_C_OUT <= DSP_C_OUT;
  end if;
  
  end if;
  end process;
end Behavioral;
